// https://github.com/SBoudrias/mem-fs-editor#copyfrom-to-options
// globOptions: https://github.com/isaacs/node-glob#options

const Generator = require('yeoman-generator');

module.exports = class extends Generator {
	constructor(args, opts) {
		super(args, opts);
		console.log("initializing")
	}	

	// async promptin() {}

	// configuring() {}

	default() {
		// can't delete files not created by yeoman
		this.fs.delete("**/*")
	}

	writing() {
		this.fs.copyTpl(
			this.templatePath("**/*"),
			this.destinationPath("yo-generated-folder"),
			{
				name: "ASDASS WOLRD",
				description: "BYE WORLD"
			},
			{},
			{
				globOptions: {
					ignore: [ // globOptions: https://github.com/isaacs/node-glob#options
						"**/*.md",
						"**/*dontcopy*", 
					],
					dot: true
				}
			}
		)

		// this.fs.append(
		// 	this.destinationPath("yo-generated-folder/temp_folder/temp_subfile_2.py"),
		// 	"import aaa as np\n" +
		// 	"import pandas as pd\n" +
		// 	"import matplotlib as mpl",
		// 	{
		// 		trimEnd: true,
		// 		separator: "---"
		// 	}
		// )

		// this.fs.write(
		// 	this.destinationPath("yo-generated-folder/.gitignore"),
		// 	"NEW OVERWRITE"
		// )

		this.fs.append(
			this.destinationPath("yo-generated-folder/.gitignore"),
			".ignore_me",
			{
				trimEnd: true,
				separator: "\n---\n"
			}
		)
	}

	// conflicts() {}

	// install() {}

	// end() {}

};