如何编写simple组件
================

为了提高开发效率，保证不同产品之间的交互一致，我们在开发产品的过程中抽象出很多前端通用组件。同时，本着开源、分享的精神，我们将这些组件放到了GitHub的公开仓库：[https://github.com/mycolorway?query=simple](https://github.com/mycolorway?query=simple)

## 生成项目模板

为了帮助我们快速的创建一个新的simple组件，chord同学编写了一个[grunt-init](http://gruntjs.com/project-scaffolding)模板：[https://github.com/mycolorway/grunt-init-simple-sample](https://github.com/mycolorway/grunt-init-simple-sample)。

首先，确保你已经安装了node和npm：[https://docs.npmjs.com/getting-started/installing-node](https://docs.npmjs.com/getting-started/installing-node)

然后，安装grunt-init：

```
npm install -g grunt-init

```

安装项目模板：

```
git clone https://github.com/mycolorway/grunt-init-simple-sample.git ~/.grunt-init/simple-sample

```

最后，通过模板生成新的组件项目，假设你的新组件名字叫simple-calendar：

```
mkdir simple-calendar && cd simple-calendar
grunt-init simple-sample
```

## 编辑bower配置

彩程的前端组件都会发布到[bower](http://bower.io/)，通过bower可以方便的管理项目的前端依赖。

首先，安装bower：

```
npm install -g bower

```

然后，编辑bower.json文件，确认name、version、main（入口脚本）、keywords等字段是否正确，然后添加项目依赖（如果有的话）：

```
"dependencies": {
  "jquery": "2.x",
  "simple-module": "~2.0.5"
}

```

最后，输入输入命令安装这些依赖：

```
bower install
```

这些项目依赖会被安装到/vendor/bower文件夹（安装路径配置在.bowerrc）。

## 编辑npm配置

一方面simple组件使用了[grunt](http://gruntjs.com/)（基于npm）作为自动化任务工具，另一方面simple组件也会直接发布到npm上，供node用户和各种模块化工具使用。

首先，安装grunt-cli：

```
npm install -g grunt-cli

```

然后编辑package.json，检查name、version、main、keywords等字段，添加项目依赖（dependencies），根据需要修改开发依赖（devDependencies，通常都是grunt插件）。

最后，安装这些项目依赖（安装路径是node_modules）：

```
npm install
```

## 编辑Gemfile

目前simple组件使用的sass编译工具是grunt官方的sass插件[grunt-contrib-sass](https://github.com/gruntjs/grunt-contrib-sass)，这个插件依赖ruby的sass编译器，所以我们在项目模板里面增加了Gemfile，里面只有sass这一个gem。如果项目里面不需要编译sass，可以删除Gemfile，否则就需要安装sass gem：

```
bundle install
```

以后，我们可能会转而使用[grunt-sass](https://github.com/sindresorhus/grunt-sass)，这个grunt插件不依赖ruby的sass编译器，而是依赖可以通过node安装的[libsass](http://libsass.org/)，到时候就可以在项目模板里去掉Gemfile了。

## 编辑Gruntfile

simple组件使用grunt作为自动化任务的工具，经常使用的自动化任务有：

*   编译CoffeeScript文件（grunt-contrib-coffee）
*   编译Sass文件（grunt-contrb-sass）
*   运行测试用例（grunt-contrib-jasmine）
*   对源代码进行模块化打包，支持AMD、commonjs等不同模块化加载方式（grunt-umd）
*   在开发过程中监测文件变化，自动编译、运行测试等（grunt-contrib-watch）

我们在在执行grunt-init初始化项目的时候已经自动生成了这些常用grunt任务的配置，现在只需要根据需要编辑一下[Gruntfile.coffee](http://gruntjs.com/getting-started#the-gruntfile)。

## 关于grunt-umd

前面提到，我们会使用grunt-umd对simple组件进行模块化打包处理，支持的加载方式有三大类：

1.  传统的global变量，例如：simple.calendar
2.  AMD模块，例如[RequireJS](http://requirejs.org/)
3.  类CommonJS的模块，例如Node

需要注意的是，无论是对应哪种加载方式，组件都只能暴露一个对象，也就是grunt-umd的objectToExport配置指定的对象。

因为simple组件特殊的global暴露方式（以simple作为napmespace），我们为grunt-umd指定了特殊的打包模板（umd.hbs），给global加载方式添加了一行代码（umd.hbs，13行）：

```
root.simple = root.simple || {};
```

## 编写前端组件

接下来就可以开始编写组件代码了。simple组件都基于抽象类[simple-module](https://github.com/mycolorway/simple-module)开发，所以新组件会是一个继承自SimpleModule的class：

```
class Calendar extends SimpleModule

```

开发的过程中需要注意：

*   尽量避免源代码里写UI文案，尽量在使用的时候通过参数传入或者在dom元素的attribute上指定
*   避免不了的文案需要做i18n处理，简单的可以用SimpleModule自带的i18n方法，复杂的就需要用第三方的前端i18n工具
*   注意实例变量和实例方法的命名，不想暴露的变量和方法以“_”开头

## 编写测试用例

所有的simple组件都要求用[Jasmine](http://jasmine.github.io/)编写测试用例，刚开始可以只覆盖一些重要、基础的功能，在后续开发中再继续补测试。

编写测试的时候注意把测试描述用完整通顺的句子写清楚。

## 发布到bower

在bower上发布新版本是自动的，只需要在GitHub上创建新的release就可以了，但是需要提前把组件注册到bower上：

```
bower register simple-calendar git@github.com:mycolorway/simple-calendar.git

```

发布新版本之前注意检查bower.json里的版本号，先改版本号然后再创建新的release。

## 发布到npm

在npm上发布新版本也很简单，首先确认package.json里的版本号是否正确（npm是不允许重复发布低版本的），然后直接输入命令：

```
npm publish
```
