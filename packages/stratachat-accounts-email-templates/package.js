Package.describe({
	name: 'stratachat:accounts-email-templates',
	version: '0.1.0',
	summary: 'Extend Rocket.Chat user account emails with stratachat-specific html templates',
	git: 'TBD',
	documentation: 'README.md'
});

Package.onUse(function (api) {
	api.use('ecmascript');
	// Babel runtime is required for some compiled syntax to work
	api.imply('babel-runtime');
	// Custom accounts email template overrides
	api.addFiles('server/main.js', 'server');
});

Package.onTest(function (api) {
	api.use('tinytest', ['server', 'client']);
	api.use('test-helpers', ['server', 'client']);
	api.addFiles('tests/server/startup-tests.js', ['server']);
});
