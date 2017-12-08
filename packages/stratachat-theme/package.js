Package.describe({
	name: 'stratachat:theme',
	version: '0.1.0',
	summary: 'Strata.chat theme customisations.',
	git: 'https://github.com/4thparty/strata.chat'
});

Package.onUse(function(api) {
	api.versionsFrom('1.2');

	api.use([
		'ecmascript',
		'coffeescript',
		'templating',
		'rocketchat:lib',
		'rocketchat:theme',
		'aldeed:template-extension@4.1.0'
	]);

	api.use('templating', 'client');

	api.addAssets([
		'assets/theme.less'
	], 'server');

	api.addFiles([
		'server.coffee'
	], 'server');

	api.addFiles([
		'views/home.html',
		'views/loginLayout.html',
		'views/welcome.html',
		'client.coffee'
	], 'client');

	api.addAssets([
		'assets/bg.png'
	], 'client');

});
