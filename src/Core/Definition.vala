public class Core.Definition {
    string headword;
    string part_of_speech;
    string url;

    Sense[] senses;

    public class Sense {
        string[] definitions;
        string synonym;

        public class Example {
            string text;

            Audio[] audios;

            public class Audio {
                string lang;
                string type;
                string url;
            }
        }
    }

    public class Pronunciation {
        string ipa;
        string lang;

        Audio[] audio;

        public class Audio {
            string lang;
            string type;
            string url;
        }
    }
}
