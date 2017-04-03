namespace Widgets {
    public class WordListRow : Gtk.ListBoxRow {

        Core.Definition definition;

        public WordListRow(Core.Definition definition) {
            this.definition = definition;
            add(new WordContainerGrid());
        }

        public class WordContainerGrid : Gtk.Grid {
            Gtk.Label headword;

            construct {
                headword = new Gtk.Label("Word here");
                add(headword);
            }

            public WordContainerGrid() {

            }
        }

        public Core.Definition get_definition () {
            return definition;
        }
    }
}
