% Boilerplate Sheet Music for Small Acoustic Pop Ensembles
%
% Copyright (c) 2024 Jenna Chen. Licensed under MIT
%
% You keep your own pieces generated with the boilerplate
%  in any license you prefer.


% Set compatible LilyPond version.
\version "2.22.1"

% Adjust the size of a sheet music.
#(set-global-staff-size 20)

% Set the tuning of guitaleles,
%  which is not prebuilt in LilyPond.
guitalele-tuning = \stringTuning <a d' g' c'' e'' a''>

% Set the tuning of baritone ukuleles,
%  which is not prebuilt in LilyPond.
baritone-ukulele-tuning = \stringTuning <d g b e'>

% The parameters used by a piece.
piece-title = "The Title"
piece-composer = "The Composer"
piece-parameter = {
    % Set the key signature.
    \key c \major
    % Set the time signature.
    \numericTimeSignature
    \time 4/4
    % Set the tempo.
    \tempo 4 = 88
}

% Record the chords of a piece.
% \chords is a builtin command in LilyPond.
% Don't use chords as a variable name.
chord = \chordmode {
    % Don't show any text when no chord set.
    % Replace the default "N.C." to save space.
    \set noChordSymbol = ""

    % Write your chord names here.
    s1
    \bar "|."  % The end of a piece.
}

% Record the melody of a piece.
melody = {
    % Write your melody here.
    s1
    \bar "|."
}

% Record the lyrics of a piece.
lyric = \lyricmode {
    % Write your lyrics here.
    Lorem4 ipsum4 dolor4 sit8 amet8
    \bar "|."
}

% Record the harmony of a piece.
harmony = {
    % Write your harmony here.
    s1
    \bar "|."
}

% Record the bassline of a piece.
bassline = {
    % Write your bassline here.
    s1
    \bar "|."
}

% Record the beats of a piece.
beat = \drummode {
    % Write your beats here.
    s1
    \bar "|."
}

% Record the piece.
piece = {
    \new StaffGroup <<
        % Create the chord name part.
        \tag #'chord \new ChordNames {
            % Recall the chord names we wrote.
            \chord
        }

        % Create the melody part.
        \new Staff \with {
            instrumentName = "Melody"
            midiInstrument = "voice oohs"
        } {
            % Use treble clef.
            \clef treble
            % Recall the parameters of the piece.
            \piece-parameter
            % Recall the melody we wrote.
            \melody
        }
        \new Lyrics \lyricmode {
            % Recall the lyrics we wrote.
            \lyric
        }

        % Create the chordal part.
        \new Staff \with {
            instrumentName = "Harmony"
            midiInstrument = "acoustic guitar (steel)"
        } {
            % Use treble clef.
            % Record the notes higher in an octave.
            \clef "treble_8"
            % Recall the harmony we wrote.
            \harmony
        }

        % Create the beat part.
        \new DrumStaff \with {
            instrumentName = "Beat"
            \override MidiInstrument #'midiInstrument = #"drum kit"

            % Assume a cajon here.
            % Record the sheet music as if a drum kit.
            %
            % Change the style table if you
            %  use other percussion instrument.
            drumStyleTable = #drums-style
        } \drummode {
            % Recall the beats we wrote.
            \beat
        }
    >>
}

% Create a sheet music.
\book {
    % Set the title and the composer of a piece.
    \header {
        title = \piece-title
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    % Create the MIDI for a piece.
    % We can explore a piece freely before your ensemble play it.
    \score {
        % Keep the chord names from the MIDI output.
        \removeWithTag #'chord
        \piece
        \midi {}
    }

    % Create the full score.
    \score {
        \piece
        % Set the layout of a sheet music.
        \layout {}
    }
}

\book {
    % Set the title and the composer of a piece.
    \header {
        title = \markup { \concat { \piece-title " (Melody Part)" }}
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \bookOutputSuffix "melody"

    % Generate a MIDI file for the melody part.
    \score {
        \new Staff \with {
            instrumentName = "Melody"
            midiInstrument = "voice oohs"
        } {
            % Use treble clef.
            \clef treble
            % Recall the parameters of the piece.
            \piece-parameter
            % Recall the melody we wrote.
            \melody
        }

        \midi {}
    }

    % Create the melody part.
    \score {
        <<
        % Create the chord name part.
        \new ChordNames {
            % Recall the chord names we wrote.
            \chord
        }

        \new Staff {
            \clef treble
            \piece-parameter
            \melody
        }
        \new Lyrics \lyricmode {
            \lyric
        }
        \new TabStaff \with {
            % Set the tuning as a ukulele.
            stringTunings = #ukulele-tuning
        } {
            \melody
        }
        >>

        \layout {}
    }
}

\book {
    % Set the title and the composer of a piece.
    \header {
        title = \markup { \concat { \piece-title " (Harmony Part)" }}
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \bookOutputSuffix "harmony"

    % Generate a MIDI file for the harmony part.
    \score {
        \new Staff \with {
            instrumentName = "Harmony"
            midiInstrument = "acoustic guitar (steel)"
        } {
            % Use treble clef.
            % Record the notes higher in an octave.
            \clef "treble_8"
            % Recall the harmony we wrote.
            \harmony
        }

        \midi {}
    }

    % Create the harmony part.
    \score {
        <<
        % Create the chord name part.
        \new ChordNames {
            % Recall the chord names we wrote.
            \chord
        }

        \new Staff {
            \clef "treble_8"
            \piece-parameter
            \harmony
        }
        \new TabStaff \with {
            % Set the tuning as a guitar.
            stringTunings = #guitar-tuning
        } {
            \harmony
        }
        >>

        \layout {}
    }
}

\book {
    % Set the title and the composer of a piece.
    \header {
        title = \markup { \concat { \piece-title " (Beat Part)" }}
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \bookOutputSuffix "beat"

    % Generate a MIDI file for the beat part.
    \score {
        \new DrumStaff \with {
            instrumentName = "Beat"
            \override MidiInstrument #'midiInstrument = #"drum kit"

            % Assume a cajon here.
            % Record the sheet music as if a drum kit.
            %
            % Change the style table if you
            %  use other percussion instrument.
            drumStyleTable = #drums-style
        } \drummode {
            % Recall the beats we wrote.
            \beat
        }

        \midi {}
    }

    % Create the beat part.
    \score {
        <<
        \new DrumStaff \with {
            % Use a cajon as if it is a drum kit.
            drumStyleTable = #drums-style
        } \drummode {
            \clef percussion
            \piece-parameter
            \beat
        }
        >>

        \layout {}
    }
}
