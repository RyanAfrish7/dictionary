public class Core.Definition : Object {
    public string headword;
    public string part_of_speech;
    public string url;
    public string id;
    string[] datasets = {};

    Sense[] senses = {};
    Pronunciation[] pronunciations = {};

    public static Core.Definition parse_json(Json.Object root) {

        Core.Definition obj = new Core.Definition ();

        Json.Array datasets = root.get_array_member("datasets");
        for(uint i = 0; i < datasets.get_length(); i++)
            obj.datasets += datasets.get_string_element(i);

        obj.headword = root.get_string_member("headword");
        obj.id = root.get_string_member("id");
        obj.part_of_speech = root.get_string_member("part_of_speech");

        Json.Array pronunciations = root.get_array_member ("pronunciations");
        for (uint i = 0; i < pronunciations.get_length (); i++)
            obj.pronunciations += Pronunciation.parse_json (pronunciations.get_object_element(i));

        Json.Array senses = root.get_array_member ("senses");
        for (uint i = 0; i < senses.get_length (); i++)
            obj.senses += Sense.parse_json (senses.get_object_element (i));

        obj.url = root.get_string_member("url");

        return obj;

    }

    public class Sense {
        string[] definitions = {};
        public string synonym;
        public string lexical_unit;
        public string signpost;
        public string opposite;

        Example[] examples = {};
        CollocationExample[] collocation_examples = {};
        GramaticalExample[] grammatical_examples = {};

        public class Example {
            public string text;

            Audio[] audios = {};

            public class Audio {
                public string type;
                public string url;

                public static Audio parse_json(Json.Object root) {
                    Audio obj = new Audio();

                    obj.type = root.get_string_member("type");
                    obj.url = root.get_string_member("url");

                    return obj;
                }
            }

            public static Example parse_json (Json.Object root) {
                Example obj = new Example ();

                obj.text = root.get_string_member ("text");

                Json.Array audios = root.get_array_member ("audio");
                for (uint i = 0; i < audios.get_length (); i++)
                    obj.audios += Audio.parse_json (audios.get_object_element (i));

                return obj;
            }
        }

        public class CollocationExample {
            public Example example;
            public string collocation;

            public static CollocationExample parse_json (Json.Object root) {
                CollocationExample obj = new CollocationExample();

                obj.collocation = root.get_string_member ("collocation");

                obj.example = Example.parse_json (root.get_object_member ("example"));

                return obj;
            }
        }

        public class GramaticalExample {
            Example[] examples = {};
            public string pattern;

            public static GramaticalExample parse_json (Json.Object root) {
                GramaticalExample obj = new GramaticalExample();

                obj.pattern = root.get_string_member ("pattern");

                Json.Array examples = root.get_array_member ("examples");
                for (uint i = 0; i < examples.get_length (); i++)
                    obj.examples += Example.parse_json (examples.get_object_element (i));

                return obj;
            }
        }

        public static Sense parse_json (Json.Object root) {
            Sense obj = new Sense();

            Json.Array definitions = root.get_array_member ("definition");
            for (uint i = 0; i < definitions.get_length (); i++)
                obj.definitions += definitions.get_string_element(i);

            Json.Array examples = root.get_array_member ("examples");
            for (uint i = 0; i < examples.get_length (); i++)
                obj.examples += Example.parse_json (examples.get_object_element (i));

            Json.Array grammatical_examples = root.get_array_member("gramatical_examples");
            for (uint i = 0; i < grammatical_examples.get_length (); i++)
                obj.grammatical_examples += GramaticalExample.parse_json (grammatical_examples.get_object_element (i));

            Json.Array collocation_examples = root.get_array_member("collocation_examples");
            for (uint i = 0; i < collocation_examples.get_length (); i++)
                obj.collocation_examples += CollocationExample.parse_json (collocation_examples.get_object_element (i));

            obj.lexical_unit = root.get_string_member ("lexical_unit");
            obj.signpost = root.get_string_member ("signpost");
            obj.synonym = root.get_string_member ("synonym");
            obj.opposite = root.get_string_member ("opposite");

            return obj;
        }
    }

    public class Pronunciation {
        public string ipa;
        public string lang;

        Audio[] audios = {};

        public class Audio {
            public string lang;
            public string type;
            public string url;

            public static Audio parse_json(Json.Object root) {
                Audio obj = new Audio();

                obj.lang = root.get_string_member("lang");
                obj.type = root.get_string_member("type");
                obj.url = root.get_string_member("url");

                return obj;
            }
        }

        public static Pronunciation parse_json(Json.Object root) {
            Pronunciation obj = new Pronunciation();

            Json.Array audios = root.get_array_member("audio");
            for(uint i = 0; i < audios.get_length (); i++)
                obj.audios += Audio.parse_json(audios.get_object_element (i));

            obj.ipa = root.get_string_member("ipa");
            obj.lang = root.get_string_member("lang");

            return obj;
        }
    }
}
