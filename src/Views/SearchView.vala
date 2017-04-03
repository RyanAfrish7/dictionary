public class Views.SearchView : Dictionary.View {
    Views.WordListView list_view;

    construct {
        //list_view = new Views.WordListView ();
        //add (list_view);
        add (new Gtk.Label("Hello This is Search"));
    }

    public override string get_header_name () {
        return "Search";
    }

}
