% Boilerplate Sheet Music for Small Acoustic Pop Ensembles
%
% Copyright (c) 2024 Four-String Mate. Licensed under MIT
%
% You keep your own pieces generated with the boilerplate
%  in any license you prefer.


% Set compatible LilyPond version.
\version "2.22.1"

% Adjust the size of a sheet music.
#(set-global-staff-size 20)

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

melody-instrument = "fiddle"
harmony-instrument = "acoustic guitar (steel)"
bassline-instrument = "acoustic bass"
rhythm-instrument = #"drum kit"

melody-tuning = \stringTuning <g d' a' e''>
harmony-tuning = \stringTuning <e, a, d g b e'>
bassline-tuning = \stringTuning<e,, a,, d, g,>

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

% Record the rhythms of a piece.
rhythm = \drummode {
    % Write your rhythms here.
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
            midiInstrument = \melody-instrument
        } {
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
            midiInstrument = \harmony-instrument
        } {
            \clef "treble_8"
            \piece-parameter
            % Recall the harmony we wrote.
            \harmony
        }

        % Create the bass part.
        \new Staff \with {
            instrumentName = "Bassline"
            midiInstrument = \bassline-instrument
        } {
            \clef "bass_8"
            \piece-parameter
            % Recall the bassline we wrote.
            \bassline
        }

        % Create the rhythm part.
        \new DrumStaff \with {
            instrumentName = "Rhythm"
            \override MidiInstrument #'midiInstrument = \rhythm-instrument

            % Assume a cajon here.
            % Record the sheet music as if a drum kit.
            %
            % Change the style table if you
            %  use other percussion instrument.
            drumStyleTable = #drums-style
        } \drummode {
            \clef percussion
            \piece-parameter
            % Recall the rhythms we wrote.
            \rhythm
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
            midiInstrument = \melody-instrument
        } {
            \clef treble
            \piece-parameter
            \melody
        }

        \midi {}
    }

    % Create the melody part.
    \score {
        <<
        \new ChordNames {
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
            stringTunings = #melody-tuning
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
            midiInstrument = \harmony-instrument
        } {
            \clef "treble_8"
            \harmony
        }

        \midi {}
    }

    % Create the harmony part.
    \score {
        <<
        \new ChordNames {
            \chord
        }

        \new Staff {
            \clef "treble_8"
            \piece-parameter
            \harmony
        }
        \new TabStaff \with {
            stringTunings = #harmony-tuning
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
        title = \markup { \concat { \piece-title " (Bassline Part)" }}
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \bookOutputSuffix "bassline"

    % Generate a MIDI file for the bassline part.
    \score {
        \new Staff \with {
            instrumentName = "Bassline"
            midiInstrument = \bassline-instrument
        } {
            \clef "bass_8"
            \bassline
        }

        \midi {}
    }

    % Create the bassline part
    \score {
        <<
        \new ChordNames {
            \chord
        }

        \new Staff {
            \clef "bass_8"
            \piece-parameter
            \bassline
        }
        \new TabStaff \with {
            stringTunings = #bassline-tuning
        } {
            \bassline
        }
        >>

        \layout {}
    }
}

\book {
    % Set the title and the composer of a piece.
    \header {
        title = \markup { \concat { \piece-title " (Rhythm Part)" }}
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \bookOutputSuffix "rhythm"

    % Generate a MIDI file for the rhythm part.
    \score {
        \new DrumStaff \with {
            instrumentName = "Rhythm"
            \override MidiInstrument #'midiInstrument = \rhythm-instrument

            % Assume a cajon here.
            % Record the sheet music as if a drum kit.
            %
            % Change the style table if you
            %  use other percussion instrument.
            drumStyleTable = #drums-style
        } \drummode {
            \rhythm
        }

        \midi {}
    }

    % Create the rhythm part.
    \score {
        <<
        \new DrumStaff \with {
            % Use a cajon as if it is a drum kit.
            drumStyleTable = #drums-style
        } \drummode {
            \clef percussion
            \piece-parameter
            \rhythm
        }
        >>

        \layout {}
    }
}
