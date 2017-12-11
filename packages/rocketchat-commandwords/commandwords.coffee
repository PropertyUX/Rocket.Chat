class CommandWords
	constructor: (message) ->

		if _.trim message.html

			debugger

			# Because Autolinker or Mentions will alter any occurrences of 'message@user',
			# we need to look at the original message text (message.msg)
			# and replace message.html with our markup. NOTE: any other markup
			# will be overwritten, but this is currently unavoidable.
			replaced = message.msg.replace /\[\[([^@\]]*)@([^\]]+)]]/gi, (match, text, recipient) ->

				# note we can only send to online users
				if recipient and Meteor.users.findOne { username: recipient }
				  return "<span class=\"command-word\" data-recipient=\"#{recipient}\">#{text}</span>"
				else
					return "<span class=\"command-word\">#{text}</span>"

			if (replaced != message.msg)
				message.html = replaced

			# A commandword without a recipient should make it through the renderMessage 
			# pipeline unharmed, in which case we can directly inject our markup into the HTML
			replaced = message.html.replace /\[\[([^@\]]*)]]/gi, (match, text) ->

				return "<span class=\"command-word\">#{text}</span>"

			message.html = replaced if replaced != message.html

		return message

debugger
RocketChat.callbacks.add 'renderMessage', CommandWords

Template.room.events 'click .command-word': (event, instance) ->
	event.stopPropagation()

	# see if we have a message recipient
	recipient = event.currentTarget.getAttribute('data-recipient');

	# if there is a recipient, create a DM with them
	if !!recipient
		Meteor.call 'createDirectMessage', recipient, (error, result) ->
			unless error

				# create and send the message
				Meteor.call 'sendMessage', { _id: Random.id(), rid: result.rid, msg: event.target.innerText }

				# goto the room/DM
				FlowRouter.go('direct', { username: recipient })

	else
		# create and send the message
		Meteor.call 'sendMessage', { _id: Random.id(), rid: instance.data._id, msg: event.target.innerText }

	# focus the messagebox
	$('.input-message').focus()

	return
