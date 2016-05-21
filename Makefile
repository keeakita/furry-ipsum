HAML=$(wildcard haml/*.haml)
HTML=$(addprefix public/,$(notdir $(HAML:.haml=.html)))

all: html

html: $(HTML)

public/%.html: haml/%.haml
	haml $< > $@

clean:
	rm $(HTML)

.PHONY: clean
