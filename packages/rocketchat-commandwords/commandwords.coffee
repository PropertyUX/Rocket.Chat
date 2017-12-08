class CommandWords
	constructor: (message) ->

		if _.trim message.html

			# NOTE : because something else in the rendering pipeline may have already altered the HTML
			# (e.g. converting @user to a mention-link), we look at the original message.msg but ultimately
			# replace the HTML, overwriting any markup previously added
			message.html = message.msg.replace /\[\[([^@\]]*)@?([^\]]*)]]/gi, (match, text, recipient) ->

				# note this will only work for currently-online users
				if recipient and Meteor.users.findOne { username: recipient }
					return "<span class=\"command-word\" data-recipient=\"#{recipient}\">#{text}</span>"
				else
					return "<span class=\"command-word\">#{text}</span>"

		return message

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
	instance.find('.input-message').focus()

	return
