mad-generation-loss
===================

    I saw the best minds of my generation destroyed by madness

Mad Generation Loss takes a recording—here Allen Ginsburg reading the first section of his seminal "Howl"—and every second re-encodes the recording again and again. The result is a second by second descent into a kind of digital madness, and at the end of the 3:18 clip near total destruction.

    Mad generation! down on the rocks of Time!
    
The final audio recording is [hosted on SoundCloud](https://soundcloud.com/thisisparker/mad-generation-loss).

If you'd like to run the script yourself, you'll need to have `mp3info`, `mp3splt`, `mp3wrap`, `sox` (including `libsox-fmt-mp3`), and `lame` installed.

For reference, this 3:18 clip requires encoding about 20,000 mp3s.

The `sh` version of the script requires only `bash`, `sox`, and `lame`.  It will only go through 210 mp3 encodings for a 3:30 clip. It produces a very different effect on [the same audio recording as above](https://soundcloud.com/thisisparker/mad-generation-loss-20/s-GD9vr).

More information available on my [blog post describing the project](http://parkerhiggins.net/2015/10/mad-generation-loss/).
