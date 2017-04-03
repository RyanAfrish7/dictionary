public class DictionaryAPI {

  public static string[] suggestWords(string word) {

    string[] suggestions = {};

    var uri = @"http://api.pearson.com/v2/dictionaries/ldoce5/entries?headword=$word*&limit=5";

    var session = new Soup.Session ();
    var message = new Soup.Message ("GET", uri);
    session.send_message (message);

    try {
        var parser = new Json.Parser();
        parser.load_from_data((string) message.response_body.flatten().data, -1);

        var root_object = parser.get_root().get_object ();
        var results = root_object.get_array_member("results");

        stdout.printf("Searching %s, %lld obtained of %lld results\n\n", word, (int64) results.get_length(), (int64) root_object.get_int_member("total"));
        stdout.flush();

        foreach (var w in results.get_elements())
          suggestions += w.get_object().get_string_member("headword");

    } catch (Error e) {
        stderr.printf(e.message);
    }

    return suggestions;
  }

}
