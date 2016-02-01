part of mdlmustache;

/// A Template can be efficiently rendered multiple times with different
/// values.
class Template {
    final String source;
    final bool _lenient;
    final bool _htmlEscapeValues;
    final String _name;
    final PartialResolver _partialResolver;
    final String _delimiters;

    List<Node> _nodes = null;

    /// The constructor parses the template source and throws [TemplateException]
    /// if the syntax of the source is invalid.
    /// Tag names may only contain characters a-z, A-Z, 0-9, underscore, and minus,
    /// unless lenient mode is specified.
    factory Template(final String source, {
        bool lenient, bool htmlEscapeValues, String name,
        PartialResolver partialResolver,
        String delimiters }) = Template.fromSource;

    Template.fromSource(String source,
        { bool lenient: false,
        bool htmlEscapeValues: true,
        String name,
        PartialResolver partialResolver,
        String delimiters: "{{ }}" })
        : source = source,
            _nodes = parse(source, lenient, name, delimiters),
            _lenient = lenient,
            _htmlEscapeValues = htmlEscapeValues,
            _name = name,
            _partialResolver = partialResolver,
            _delimiters = delimiters;

    String get name => _name;

    /// [values] can be a combination of Map, List, String. Any non-String object
    /// will be converted using toString(). Null values will cause a
    /// [TemplateException], unless lenient module is enabled.
    String renderString(values) {
        var buf = new StringBuffer();
        render(values, buf);
        return buf.toString();
    }

    /// [values] can be a combination of Map, List, String. Any non-String object
    /// will be converted using toString(). Null values will cause a
    /// [TemplateException], unless lenient module is enabled.
    void render(values, StringSink sink) {
        var renderer = new Renderer(
            sink,
            [values],
            _lenient,
            _htmlEscapeValues,
            _partialResolver,
            _name,
            '',
            source);

        renderer.render(_nodes);
    }
}

// Expose getter for nodes internally within this package.
getTemplateNodes(Template template) => template._nodes;
