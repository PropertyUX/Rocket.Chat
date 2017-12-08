Package.describe({
	name: 'rocketchat:commandwords',
	version: '0.0.1',
	summary: 'converts certain words to clickable DMs'
});

Package.onUse(function(api) {
	api.versionsFrom('1.2.1');

	api.use([
		'templating',
		'coffeescript',
		'rocketchat:lib',
		'rocketchat:theme',
		'rocketchat:ui-message'
	]);

	api.addFiles('commandwords.coffee', 'client');
	api.addFiles('styleLoader.coffee', 'server');
	api.addAssets('styles.less', 'server');
});
