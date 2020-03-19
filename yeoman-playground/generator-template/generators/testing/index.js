const Generator = require('yeoman-generator');

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    // This makes `appname` a required argument.
    this.argument("appname", { type: String, required: false });

    // option flags
    this.option("test", {
    	desc: "this is the option descriptor",
    	alias: "what the hell is going on"
    })
    // console.log(this.options.test)

    // // And you can then access it later; e.g.
    // this.log(this.options.appname);

    // // reviewing the yo-rc file
    // console.log(this.config.getAll())

    this.config.set({
    	"MAKING THIS HEE" : true
    })

    this.config.save()

    console.log('initializing')
  }

  method() {
  	console.log(
  		this.options,
  		this.config.getAll()
	)
  }

	// async prompting() {
	// 	const answers = await this.prompt(
 //    	[{
	//         type: 'input',
	//         name: 'name',
	//         message: 'Your project name',
	//         default: this.appname, // Default to solution folder name
	//       }, {
	//         type: 'list',
	//         name: 'license',
	//         message: 'What license should be used?',
	//         choices: ['UNLICENSED', 'MIT'],
	//         default: 'MIT',
	//       }, {
	//         type: 'confirm',
	//         name: 'travis',
	//         message: 'Would you like to enable a travis build?',
	//         default: true,
	//       }
	//     ]);
	// }

 //    writing() {
 //    	const self = this;
 //    	self.fs.copy(
 //    		self.templatePath(),
 //    		self.destinationPath(),
 //    		// self.destinationRoot(),
 //    		// { globOptions: { dot: true } },
	// 	);

	// 	self.fs.copyTpl(
	// 		self.templatePath(),
	// 		self.destinationPath(),
	// 		{X:Y, A:B},
	// 	);
 //    }

 //    install() {
 //    	this.spawnCommand(A, B);
 //    }

	// start() {
	// 	// basic prompting
	// 	this.prompt([{
	// 		type: "input",
	// 		name: "name",
	// 		message: "new component"
	// 	}]).then((answer) => {
	// 		this.destinationRoot(answer.name);
	// 	})

	// 	// copy folders
	// 	this.fs.copyTpl(
	// 		this.templatePath("temp_folder"),
	// 		this.destinationRoot("temp_folder")
	// 	)
	// }

	method1() {
		console.log("random method")
	}
};