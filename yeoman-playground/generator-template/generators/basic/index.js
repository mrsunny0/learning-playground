const Generator = require('yeoman-generator');

module.exports = class extends Generator {
	method1() {
		this.fs.copyTpl(
			this.templatePath("*"),
			this.destinationRoot("basic-template"),
			{
				message : "HELLO WORLD"
			}
		)
	}
}