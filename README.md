## Countries

A sample project that fetches a list of countries from https://restcountries.eu and shows some data about them.

[![Build Status](https://travis-ci.org/mapostolakis/Countries.svg?branch=dev)](https://travis-ci.org/mapostolakis/Countries)

App icons by [icons8.com](https://icons8.com/).

---

## Introduction

[Countries](https://github.com/mapostolakis/Countries) is an Objective-C, open source project, demonstrating some techniques for creating reusable components and abstractions using Apple’s platforms. Its goal is to show how to develop one component at a time and try not to care about making decisions beforehand. It uses the SOLID principles and various design patterns that we will go through in depth in future posts. This series of posts does not attempt to show the one and only correct approach for building an app. It rather shows how you can prepare to react positively to change, simply by following some disciplines.

The source code of the project can be on [Github](https://github.com/mapostolakis/Countries).

## Starting point

My first thought after I decided that I will start developing this app, was where should I start from. It is common to immediately start laying out some folder structure, even maybe bring in some libraries that you know you always use in your projects. I believe this could lead in problematic situations, because most probably you don’t even know what you are going to build yet. Maybe you have an idea, like in this case for instance, where you will create a project that will be about some countries, as the project name indicates. But thats it. Maybe you have some more information available, like you are going to consume a remote API and persist the data on the device. Even in this case though, thats all you know. It could be tempting to lay out some view controllers on the storyboard, because you know that they will be needed, but even then this creates another dilemma. Am I going to use a storyboard or maybe create my UI programmatically? Most probably you are not fully aware of the needs of your product nor the form of it yet.

So instead of thinking about the implementation details, maybe you can concentrate on the responsibilities you are going to need and what your app will actually do. I believe it doesn’t matter where you start from, as long as your choice doesn’t tie you down with a process that is hard to change later in your development cycle.

Having said that, lets define our core responsibility of your application. I want this application to show a collection of countries and some details about each one of them. Someone could argue that this app is shouting “master-detail” design and as shown later this is the presentation decision I made. However the important thing is to remember that at this point a “master-detail” design is just an implementation detail. There can be an unknown number of what-ifs that could change the specs of a product. I want to make sure though that my design can be adaptable to most of these changes. So lets write down what the app will do:

- The app will show a collection of countries.
- The app will show some details for each country.

![Responsibilities v Implementation](https://dl.dropboxusercontent.com/u/1919445/responsibilities.png)

You may think that after all this time, I haven’t done any serious work. I will respectfully disagree. I have set a very clear path to our journey. I stated that I do not care if this is going to be an iPhone app, or an iPad app, an Apple TV app or even a console application. Simply I do not care how it is going to look like, or where it is going to get the data from. I do not care because I do not want to start making assumptions. All these options have one thing in common. They will all do the same thing. They will at some point get a list of countries and show the details for each one of those countries. And this is all I care for right now.
