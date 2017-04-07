public class Dictionary.MainWindow : Gtk.ApplicationWindow {

    private Gtk.HeaderBar headerbar;
    private Gtk.Stack stack;
    private Gtk.SearchEntry search_entry;
    private Gtk.Revealer view_mode_revealer;
    private Gtk.Stack custom_title_stack;
    private Gtk.Stack button_stack;
    private Gtk.Label custom_header;
    private Gtk.Button return_button;

    private Granite.Widgets.ModeButton view_mode;

    private Views.SearchView search_view;
    private Views.RecentView recent_view;
    private Views.BookmarkView bookmark_view;
    private Views.DefinitionView definition_view;

    private Gee.LinkedList<View> return_history;

    public MainWindow(Gtk.Application app) {
        Object (application: app);

        search_entry.search_changed.connect (trigger_search);
        search_entry.key_press_event.connect ((event) => {
            if (event.keyval == Gdk.Key.Escape) {
                search_entry.text = "";
                return true;
            }
            return false;
        });

        search_entry.grab_focus_without_selecting();
        view_mode.selected = 0;

        view_mode.notify["selected"].connect (() => {
            switch (view_mode.selected) {
                case 0:
                    stack.set_visible_child (recent_view);
                    break;
                case 1:
                    stack.set_visible_child (bookmark_view);
                    break;
            }
        });

        search_view.show_definition.connect (show_definition);
        recent_view.show_definition.connect (show_definition);
        bookmark_view.show_definition.connect (show_definition);

        return_button.clicked.connect (on_return_clicked);
    }

    public void show_definition (Core.Definition definition) {
        definition_view.set_definition (definition);
        push_view (definition_view);
    }

    construct
    {
        title = "Dictionary";
        window_position = Gtk.WindowPosition.CENTER;

        set_size_request (800, 640);

        view_mode = new Granite.Widgets.ModeButton ();
        view_mode.append_text ("Recent");
        view_mode.append_text ("Bookmarks");

        view_mode_revealer = new Gtk.Revealer ();
        view_mode_revealer.reveal_child = true;
        view_mode_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
        view_mode_revealer.add(view_mode);

        search_entry = new Gtk.SearchEntry ();
        search_entry.placeholder_text = "Search words";

        custom_header = new Gtk.Label("Search");
        custom_header.get_style_context ().add_class (Gtk.STYLE_CLASS_TITLE);

        custom_title_stack = new Gtk.Stack ();
        custom_title_stack.add (view_mode_revealer);
        custom_title_stack.add (custom_header);

        button_stack = new Gtk.Stack ();

        return_button = new Gtk.Button.with_label ("Home");
        return_button.get_style_context ().add_class ("back-button");
        button_stack.add (return_button);

        button_stack.no_show_all = true;

        headerbar = new Gtk.HeaderBar ();
        headerbar.show_close_button = true;
        headerbar.set_custom_title (custom_title_stack);
        headerbar.pack_start (button_stack);
        headerbar.pack_end (search_entry);

        set_titlebar (headerbar);

        search_view = new Views.SearchView();
        recent_view = new Views.RecentView();
        bookmark_view = new Views.BookmarkView();
        definition_view = new Views.DefinitionView();

        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        stack.add (recent_view);
        stack.add (bookmark_view);
        stack.add (search_view);
        stack.add (definition_view);

        add (stack);

        return_history = new Gee.LinkedList<View> ();
    }

    private void trigger_search () {
        unowned string search = search_entry.text;
        if (search.length < 2) {
            if (stack.get_visible_child () == search_view) {
                pop_view ();
            }
        } else {
            if (stack.get_visible_child () != search_view) push_view (search_view);
            search_view.search(search_entry.text);
        }
    }

    private void push_view (View new_view) {

        if(return_history.is_empty) {
            button_stack.no_show_all = false;
            button_stack.show_all ();
            view_mode_revealer.reveal_child = false;
            custom_title_stack.set_visible_child (custom_header);
        }

        View old_view = stack.get_visible_child () as View;
        return_history.offer_head (old_view);
        stack.set_visible_child (new_view);
        custom_header.label = new_view.get_header_name ();
        return_button.label = old_view.get_header_name ();
    }

    private void pop_view () {
        View current_view = stack.get_visible_child() as View;
        if(!return_history.is_empty) {
            View previous_view = return_history.poll_head ();
            stack.set_visible_child (previous_view);

            custom_header.label = previous_view.get_header_name ();
            if(!return_history.is_empty)
                return_button.label = return_history.peek_head ().get_header_name ();
            else {
                button_stack.hide();
                custom_title_stack.set_visible_child(view_mode_revealer);
            }
        }
        else {
            return_button.label = "Home";
            button_stack.hide();
            custom_title_stack.set_visible_child(view_mode_revealer);
            view_mode_revealer.reveal_child = true;
        }
    }

    private void on_return_clicked() {
        if(stack.get_visible_child() == search_view) {
            search_entry.text = "";
        }

        pop_view ();
    }
}
