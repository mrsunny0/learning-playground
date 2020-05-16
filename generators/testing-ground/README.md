# Template Github Portfolio Website

A modular template github page to showcase project details and images to interested users.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Requires a Github user account, and github page settings turned on. Please read the [Deployment Section](##Deployment) for instructions on setting this up.
- Node version > 12
- Gulp 4.0
- Ruby 2.7
- (*Optional*) Rbenv > 1.1

### Installing

Please follow the respective software package installation instructions from the source:
- Node
- Gulp
- Rbenv for Ruby

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running

The project is developed by running gulp tasks to compile, minimize, and create assets files for local development and github deployment.

### File structure

Explain what these tests test and why

```
Give an example
```

### Data binding

`config.yml`

`data`

`includes`

### Using Gulp

The `_site` folder is used to locally store changes to the project and create the server from. The `assets` folder is what the Github Jekyll framework will use to access resources.

```bash
# build files into assets and _site folder
gulp build

# watch for changes
gulp
```

## Deployment

Please review Github's step-by-step guidline on setting up a [github page](https://pages.github.com/), and using [Jekyll's static-site generator](https://jekyllrb.com/docs/github-pages/) framework for deploying custom sites to your personal repo. An FAQ on Github's setup with Jekyll can be found [here](https://help.github.com/en/github/working-with-github-pages/setting-up-a-github-pages-site-with-jekyll).

Note the distinction between a personal github page, a repository github page, and a github wiki. Guidelines for each can be found here:
- [Github page](https://guides.github.com/features/pages/) - publish to your `https://<username>.github.io/`
- [Repository github page](https://help.github.com/en/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site) - publish on your local repository, created a named branch `gh-pages`
- [Github wiki](https://help.github.com/en/github/building-a-strong-community/adding-or-editing-wiki-pages) - wiki pages can be made for all github projects, not for webhosting.

## Built With

### From-end tools
* [Github Pages](https://rometools.github.io/rome/) - Used to host 
* [HTM5, CSS3, and SCSS](https://rometools.github.io/rome/) - Front-end web technology
* [Jekyll](https://maven.apache.org/) - Framework to render site on github
* [Gulp 4](https://rometools.github.io/rome/) - Development framework to build locally
* [VSCode](http://www.dropwizard.io/1.0.2/docs/) - Popular IDE that was developed on

### Conventions
* [BEM](http://getbem.com/) - A useful methodology for working with HTML and CSS

### Multi-media software
* [ffmpeg](https://www.ffmpeg.org/) - converting and compressing videos of all types
* [imagemagick](https://imagemagick.org/index.php) - converting image file formats 
* [Fiji (imageJ)](https://fiji.sc/) - an frequently used academic software tool used for biological image processing, but has its use in a versatile range of image processing applications.
* [illustrator](https://www.adobe.com/products/illustrator.html) - creating vectorized designs and logos
* [photoshop](https://www.adobe.com/products/photoshop.html) - touching up images
* [powerpoint](https://www.microsoft.com/en-us/microsoft-365/powerpoint) - used to collage images for quick prototyping

### Online resources
* [pexels](https://www.pexels.com/) - great resource for free usable images
* [unsplash](https://unsplash.com/) - another great resource for gree and usable images
* [coverr](https://coverr.co/) - an amazing website with stock cover videos

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) as an example for our code of conduct, coding guidelines, and and the process for submitting pull requests.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **George Sun** - *Main Contributor* - [Personal Page](https://github.com/mrsunny0)
* **Sun Websites** - *Host* - [Company Page]()

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details. (*Currently under development*)

## Acknowledgments

Expert HTML5 and CSS3 users who indirectly influenced this work

* Jonas Schmedtman for teaching incredible courses on web technologies. [Github page](https://github.com/jonasschmedtmann). [Website](https://codingheroes.io/)
* Mauricio Urraco for a reference github page to work off from. [Reference page](https://jekyll-theme-minimal-resume.netlify.app/). [Github page](https://github.com/murraco)

The community
* A variety of Jekyll and Gulp users who posted their project structure.