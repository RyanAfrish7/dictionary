namespace aryanware {

public class DictionaryApp {

  Gtk.Window window;
  Gtk.SearchEntry searchentry;
  Gtk.EntryCompletion entrycompletion;
  Gtk.TextView textview;

  Gtk.ListStore liststore;

  bool updateSuggestions = false;

  public DictionaryApp() throws GLib.Error {

      var builder = new Gtk.Builder();
      builder.add_from_file("dictionary.ui");
      builder.connect_signals(null);

      window = builder.get_object("window1") as Gtk.Window;
      searchentry = builder.get_object("searchentry1") as Gtk.SearchEntry;
      textview = builder.get_object("textview1") as Gtk.TextView;

      entrycompletion = new Gtk.EntryCompletion();
      liststore = new Gtk.ListStore(1, typeof(string));

      entrycompletion.set_model(liststore);
      entrycompletion.set_text_column(0);

      searchentry.set_completion(entrycompletion);

      window.destroy.connect(Gtk.main_quit);
      searchentry.search_changed.connect(on_search_changed);

      window.show_all();
  }

  async void get_suggestions(string word) throws ThreadError {
    SourceFunc callback = get_suggestions.callback;
    string[] suggestions = {};

    ThreadFunc<void*> run = () => {
      suggestions = DictionaryAPI.suggestWords(word);
      Idle.add((owned) callback);
      return null;
    };

    Thread.create<void*>(run, false);
    yield;

    Gtk.TreeIter iter;
    liststore.clear();
    stdout.printf("query for %s is updated\n", word);
    foreach (var w in suggestions) {
      liststore.append(out iter);
      liststore.set_value(iter, 0, w);
    }

    return;
  }

  public void on_search_changed() {
    get_suggestions(searchentry.get_text());
  }

  public static int main(string[] args) {
    try {
      Gtk.init(ref args);

      var app = new DictionaryApp();

      Gtk.main();
    } catch(GLib.Error e) {
      stderr.printf(e.message);
    }
    return 0;
  }

}
}
