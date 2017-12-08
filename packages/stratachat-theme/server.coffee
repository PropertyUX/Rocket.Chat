# Setup theme globals for clien
Meteor.startup ->
	instance = process.env.INSTANCE or 'default'
	RocketChat.settings.addGroup 'StrataChat'
	RocketChat.settings.add 'SC_Instance', instance, { type: 'string' , group: 'StrataChat', i18nLabel: 'Instance', public: true }
	RocketChat.settings.add 'SC_Background', "/packages/stratachat_theme/assets/bg.png", { type: 'string' , group: 'StrataChat', i18nLabel: 'Background', public: true }

# Custom LESS includes
RocketChat.theme.addPackageAsset ->
	Assets.getText 'assets/theme.less'
