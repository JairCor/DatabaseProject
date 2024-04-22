INSERT INTO artist (ARTIST_ID, ARTIST_NAME) VALUES
('A1', 'Drake'),
('A2', 'Deftones'),
('A3', 'Playboi Carti'),
('A4', 'Yeat'),
('A5', 'Lil Uzi Vert'),
('A6', 'Travis Scott'),
('A7', 'Future'),
('A8', 'Joji'),
('A9', 'Korn'),
('A10', '21 Savage'),
('A11', 'Kanye West'),
('A12', 'The Weeknd'),
('A13', 'Cigarettes After Sex'),
('A14', 'Kali Uchis'),
('A15', 'Kendrick Lamar'),
('A16', 'SZA'),
('A17', '$uicideboy$'),
('A18', 'Luke Combs'),
('A19', 'Olivia Rodrigo'),
('A20', 'Mac DeMarco'),
('A21', 'Bad Bunny'),
('A22', 'Wolfgang Amadeus Mozart'),
('A23', 'Frank Ocean'),
('A24', 'Steve Lacy');

INSERT INTO genre (GENRE_ID, GENRE_NAME) VALUES
('G1', 'Rock'),
('G2', 'Pop'),
('G3', 'Hip-hop/Rap'),
('G4', 'Electronic'),
('G5', 'Jazz'),
('G6', 'R&B'),
('G7', 'Country'),
('G8', 'Classical'),
('G9', 'Folk'),
('G10', 'Metal'),
('G11', 'Punk'),
('G12', 'Funk'),
('G13', 'Dance'),
('G14', 'Gospel'),
('G15', 'Latin'),
('G16', 'World'),
('G17', 'Ambient'),
('G18', 'Experimental'),
('G19', 'Reggaeton'),
('G20', 'Ska'),
('G21', 'Techno'),
('G22', 'Blues'),
('G23', 'Reggae'),
('G24', 'Indie');

INSERT INTO lyrics (LYRICS_ID, LYRICS_TEXT, WORD_COUNT, SONG_ID) VALUES
('L1', 'Lyrics for song 1', '150', 'S1'),
('L2', 'Lyrics for song 2', '200', 'S2');

INSERT INTO mood (MOOD_ID, SONG_ID, DATING_VAL, VIOLENCE_VAL, WORLDLIFE_VAL, NIGHTTIME_VAL, SHAKING_VAL, FAM_GOSPEL_VAL, ROMANTIC_VAL, COMMS_VAL, OBSCENE_VAL, MUSIC_VAL, MOVMTPLACES_VAL, VISUAL_VAL, FAM_SPIRIT_VAL, LIKE_GIRLS_VAL, SADNESS_VAL, FEELINGS_VAL, DANCE_VAL, LOUDNESS_VAL, ACOUSTIC_VAL, INSTRUMENT_VAL, VALANCE_VAL, ENERGY_VAL) VALUES
('M001', 'S001', 0.5, 0.7, 0.6, 0.4, 0.8, 0.2, 0.9, 0.3, 0.6, 0.7, 0.5, 0.8, 0.3, 0.7, 0.6, 0.5, 0.8, 0.7, 0.6, 0.4, 0.9),
('M002', 'S002', 0.6, 0.8, 0.7, 0.5, 0.9, 0.3, 0.8, 0.4, 0.7, 0.8, 0.6, 0.9, 0.4, 0.8, 0.7, 0.6, 0.9, 0.8, 0.7, 0.5, 0.8);

INSERT INTO playlist (PLAYLIST_ID, PLAYLIST_NAME) VALUES
('PL1', 'Hype'),
('PL2', 'Workout Pump'),
('PL3', 'Chill'),
('PL4', 'Road Trip'),
('PL5', 'R&B Groove'),
('PL6', 'Morning Motivation'),
('PL7', 'Party Starters'),
('PL8', 'Dance Floor'),
('PL9', 'Retro Rewind'),
('PL10', 'Rainy Day'),
('PL11', 'Indie Gems'),
('PL12', 'Throwbacks'),
('PL13', 'Late Night Drives'),
('PL14', 'Ambient Escapes'),
('PL15', 'Pool Party'),
('PL16', 'Night City Vibes'),
('PL17', 'Lonely Sad Mix'),
('PL18', 'Floating'),
('PL19', 'Lowkey Vibes'),
('PL20', 'Phonk'),
('PL21', 'Enough Said'),
('PL21', 'Focus Homework Mix'),
('PL22', 'Drum and Bass Mix'),
('PL23', 'Aux'),
('PL23', 'Late Night');

INSERT INTO playlist_genre (PLAYLIST_ID, GENRE_ID) VALUES
('PL1', 'G3'),
('PL2', 'G10'),
('PL3', 'G6'),
('PL4', 'G7'),
('PL5', 'G6'),
('PL6', 'G2'),
('PL7', 'G3'),
('PL8', 'G13'),
('PL9', 'G10');











