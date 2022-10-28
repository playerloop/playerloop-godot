<p align="center">
  <a href="https://playerloop.io" target="_blank" align="center">
    <img src="https://avatars.githubusercontent.com/u/97310002?s=200&v=4" width="100">
  </a>
  <br />
</p>

# PlayerLoop Godot Plugin

Get bug reports from your players, fast. Improve your game, reward the community.

If your player thinks there is a bug, you have something to fix. A lot of these do not throw exceptions in your code. With PlayerLoop, you can easily implement a bug reporting feature inside your game. You also get an easy-to-use interface to check the reports and download the savegame files and the screenshots to figure out what the problem is.

We are currently in free closed Beta! You can join us here on Discord: [![Discord Chat](https://img.shields.io/discord/929061183233884200?logo=discord&logoColor=ffffff&color=7389D8)](https://discord.gg/rGeGVqnVps)

## Getting started

If you did not do that already, head over [playerloop.io](https://playerloop.io) and sign up for an account.

To install the Godot plugin, you can either:
a) Clone this repository and move the addons folder to the root of your project.
or
b) Install it ~~from the AssetLib inside Godot Engine Editor~~ (Coming soon, we did not publish it yet)

After installing the Library, don't forget to activate it in your Project settings. Click on `Project` on the top main menu, then choose `Project Settings` and then switch to `Plugins`. Enable the library as follows:

![Activate Library](imgs/library_activate.png)

Now you need to set up your secret. Go to [playerloop.io/settings](https://playerloop.io/settings) and copy your secret to the clipboard.
Then create a `.env` file in your root folder if you don't have it yet, and add the following line inside of it:

```
SECRET=paste_your_secret_here
```

So for example if your secret is `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9` then the `.env` file should be

```
SECRET=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
```

Now you can call the `Playerloop` singleton from anywhere in your code. To upload a bug report, you can simply call:
```python
Playerloop.request.post("I found a bug in your first level!")
```

To attach one or more savegame files together with the report, you can add an array of filepaths to the report function:

```python
Playerloop.request.post("I found a bug in your first level!", ["user://savegamefile.gd"])
```

## Example project

You can find an example Godot project with a simple implementation of this library here: COMING SOON

## Full reference

Coming soon

## Contributing

Make a PR :)