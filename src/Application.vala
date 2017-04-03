using Granite.Widgets;

public class Dictionary.App : Granite.Application {

    Dictionary.MainWindow main_window;

    construct
    {
        application_id = "aryanware.eos.dictionary";
        program_name = "Dictionary";
        app_years = "2017";
        //app_icon = Build.DESKTOP_ICON;

        build_data_dir = Build.DATADIR;
        build_pkg_data_dir = Build.PKGDATADIR;
        build_release_name = Build.RELEASE_NAME;
        build_version = Build.VERSION;
        build_version_info = Build.VERSION_INFO;

        app_launcher = "aryanware.eos.dictionary.desktop";
        main_url = "https://github.com/RyanAfrish7/dictionary";
        bug_url = "https://github.com/RyanAfrish7/dictionary/issues";
        help_url = "https://github.com/RyanAfrish7/dictionary/wiki";
        translate_url = "https://github.com/RyanAfrish7/dictionary";

        about_authors = { "Afrish Khan S <ryanafrish7@gmail.com>" };
        about_comments = "";
        //about_translators = "translator-credits";
        about_license_type = Gtk.License.GPL_3_0;
        //add_main_option_entries (appcenter_options);
    }

    public override void activate () {
        if (main_window == null) {
            main_window = new Dictionary.MainWindow (this);
            main_window.destroy.connect (() => {
                    main_window = null;
                });
            add_window (main_window);
            main_window.show_all ();
        }

        main_window.present ();
    }

    public static int main (string[] args) {
        var application = new Dictionary.App ();
        return application.run (args);
    }
}
