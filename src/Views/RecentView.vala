public class Views.RecentView : Dictionary.View {
    Views.WordListView list_view;

    construct {
        list_view = new Views.WordListView ();
        add (list_view);
    }

    public override string get_header_name () {
        return "Home";
    }
}
