public class Views.SearchView : Dictionary.View {

    Views.WordListView list_view;
    GLib.ListStore search_results;

    Core.PearsonDictionaryApiClient client;

    public SearchView() {
        search_results = new GLib.ListStore (typeof (Core.Definition));
        client = new Core.PearsonDictionaryApiClient();

        list_view.bind_model (search_results, (obj) => {
                return new Widgets.WordListRow(obj as Core.Definition);
            });
    }

    construct {
        list_view = new Views.WordListView ();
        list_view.alert_view.title = "No words found";
        list_view.alert_view.description = "Ain't I the world's best dictionary? — JK";
        list_view.alert_view.icon_name = "edit-find-symbolic";

        add (list_view);
    }

    public override string get_header_name () {
        return "Search";
    }

    public void search (string word) {
        client.search_word.begin (word, (obj, res) => {
                Core.Definition[] definitions = client.search_word.end(res);
                search_results.remove_all();
                foreach (var definition in definitions)
                    search_results.append(definition);
            });
    }

}
