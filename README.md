# Boilerplate Sheet Music for Pop Ensemble

LilyPond boilerplate for small acoustic pop ensembles.

## Default Setting

There are two variants here.

A three-player ensemble setting:

* Melody: vocal or ukulele
* Harmony: acoustic guitar
* Beat: cajon

A four-player ensemble setting:

* Melody: vocal or guitalele
* Harmony: baritone ukulele
* Bassline: acoustic bass guitar or ukulele bass
* Beat: cajon

If your ensemble setting varies from either, modify the boilerplate by yourself.

## System Requirements

* A recent [LilyPond](http://lilypond.org/)

## Usage

Clone the repo locally and rename it:

```shell
$ git clone https://github.com/fourstringmate/pop-ensemble-boilerplate.git my-music
```

Alternatively, download the ZIP file or create a new repo out of this template repo.

Edit either boilerplate to create your own piece. Here are some hints:

Always write down the notes of a piece in a variable:

```latex
% Record the melody of a piece.
melody = {
    % Write your melody here.
    s1
}
```

Those same notes will be called several times. In a full score, in a score partitioning and in a tablature.

Modify the string tuning to fit your ensemble:

```latex
\score {    
    \header {
        % Omit some code.
    }

    <<
    \new Staff {
        % Omit some code.
    }
    \new TabStaff \with {
        % Set the tuning as a baritone ukulele.
        stringTunings = #baritone-ukulele-tuning
    } {
        % Omit some code.
    }
    >>

    \layout {}
}
```

You may use other lute-family instrument like acoustic guitar, ukulele, banjo or anything else. Modify it accordingly.

Modify the style of a percussion part:

```latex
\score {
    \header {
        % Omit some code.
    }

    <<
    \new DrumStaff \with {
        % Use a cajon as if it is a drum kit.
        drumStyleTable = #drums-style
    } \drummode {
        % Omit some code.
    }
    >>

    \layout {}
}
```

You may use any percussion instrument(s) other than cajon. Modify the style table to fit your instrument(s).

Finally, compile the sheet music with LilyPond:

```shell
$ lilypond your-next-awesome-piece.ly
```

You may change the name of this boilerplate sheet music as well.

## Copyright

The boilerplates are licensed under MIT.

You keep your own pieces generated with the boilerplate in any license you prefer.
