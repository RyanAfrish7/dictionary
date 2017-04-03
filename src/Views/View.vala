public abstract class Dictionary.View : Gtk.Stack {

    construct
    {
        get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        expand = true;
    }

    public abstract string get_header_name ();

}
