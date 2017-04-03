namespace Views {
    public class Views.WordListView : Gtk.ScrolledWindow {
        public signal void show_definition (Core.Definition definition);
        protected Gtk.ListBox list_box;
        public Granite.Widgets.AlertView alert_view;

        construct
        {
            alert_view = new Granite.Widgets.AlertView(":(", "No words found", "edit-find-symbolic");
            alert_view.show_all();

            list_box = new Gtk.ListBox ();
            list_box.expand = true;
            list_box.set_placeholder (alert_view);
            list_box.activate_on_single_click = true;
            list_box.row_activated.connect ((r) => {
                    var row = (Widgets.WordListRow) r;
                    show_definition(row.get_definition ());
                });
            // DEBUG
            Gdk.RGBA a = new Gdk.RGBA();
            a.parse("#eeeff0");
            list_box.override_background_color(Gtk.StateFlags.NORMAL, a);
            // END DEBUG
            add(list_box);
        }

        public void bind_model(ListModel model, Gtk.ListBoxCreateWidgetFunc func) {
            list_box.bind_model(model, func);
        }
    }
}
