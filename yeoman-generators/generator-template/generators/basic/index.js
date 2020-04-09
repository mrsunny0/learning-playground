const Generator = require('yeoman-generator');

module.exports = class extends Generator {
	method1() {
		this.fs.copyTpl(
			this.templatePath("*"),
			this.destinationRoot(),
			{
				message : "HELLO WORLD"
			},
			{},
			{
				globOptions: {
					ignore: ["**/.*"],
					dot: true
				}
			}
		)
	}
}