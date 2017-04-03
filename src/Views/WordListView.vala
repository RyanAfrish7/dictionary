namespace Views {
    public class Views.WordListView : Gtk.ScrolledWindow {
        public signal void show_definition (Core.Definition definition);
        protected Gtk.ListBox list_box;
        protected Granite.Widgets.AlertView alert_view;

        construct
        {
            alert_view = new Granite.Widgets.AlertView("No ords", "wewe", "edit-find-symbolic");

            list_box = new Gtk.ListBox ();
            list_box.expand = true;
            list_box.set_placeholder (new Gtk.Label("ping pon"));
            list_box.activate_on_single_click = true;
            list_box.row_activated.connect ((r) => {
                    var row = (Widgets.WordListRow) r;
                    show_definition(row.get_definition ());
                });
            Gdk.RGBA a = new Gdk.RGBA();
            a.parse("#eeeff0");
            list_box.override_background_color(Gtk.StateFlags.NORMAL, a);
            add(list_box);
        }
    }
}
