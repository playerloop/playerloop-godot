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

You can install this Godot plugin normally, either:
a) Clone this repository
or
b) Download it from the [Godot Asset Library](https://godotengine.org/asset-library/asset/1529)

Now unzip what you downloaded. It will contain a `addons/` folder. Paste that folder into your Godot root project (like you would for any Godot pluging).

After installing the Library, don't forget to activate it in your Project settings. Click on `Project` on the top main menu, then choose `Project Settings` and then switch to `Plugins`. Enable the library as follows:

![Activate Library](imgs/library_activate.png)

Now you need to set up your secret. Go to [playerloop.io/settings](https://playerloop.io/settings) and copy your secret to the clipboard.

Now go back inside Godot and navigate to the file `res://addons/playerloop/Playerloop/playerloop.gd`

And add the secret to line 13. So if your secret is `ghterereeesdfsdfsd`, line 13 goes from:

```python
"playerloopSecret": ""
```
to

```python
"playerloopSecret": "ghterereeesdfsdfsd"
```

Save the file and you are ready to go!

Now you can call the `Playerloop` singleton from anywhere in your code. To upload a bug report, you can simply call:
```python
Playerloop.request.post("I found a bug in your first level!")
```

To attach one or more savegame files together with the report, you can add an array of filepaths to the report function:

```python
Playerloop.request.post("I found a bug in your first level!", ["user://savegamefile.gd"])
```

## Opening the Privacy Policy page

When integrating the Bug Report interface into your game, don't forget to ask your users to accept the Playerloop Privacy Policy. It has to be a clear checkmark that is not active by default. The description of the checkmark has to link to our Privacy Policy, and to do so, you can use this function of the SDK:

```python
Playerloop.open_privacy_policy():
```

Calling this function will open the user's browser and display the Playerloop Privacy page, so it's handy to have it trigger if the user clicks on the linked words. Something like:

✅ By checking this checkmark, I accept the [Playerloop privacy policy](https://playerloop.io/privacy-policy)

Where clicking on the underlined words will trigger the function above.

## Example project

You can find an example Godot project with a simple implementation of this library here: COMING SOON

## Full reference

Coming soon

## Contributing

Make a PR :)