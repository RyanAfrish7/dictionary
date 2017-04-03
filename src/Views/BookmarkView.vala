public class Views.BookmarkView : Dictionary.View {
    Views.WordListView list_view;

    construct {
        add (new Gtk.Label("Hello This is Bookmarks"));
    }

    public override string get_header_name () {
        return "Home";
    }
}
