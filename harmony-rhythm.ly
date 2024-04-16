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

harmony-instrument = "acoustic guitar (steel)"
rhythm-instrument = #"drum kit"

harmony-tuning = \stringTuning <e, a, d g b e'>

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

% Record the harmony of a piece.
harmony = {
    % Write your harmony here.
    s1
    \bar "|."
}

% Record the rhythm of a piece.
rhythm = \drummode {
    % Write your rhythm here.
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
            % Recall the rhythms we wrote.
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
