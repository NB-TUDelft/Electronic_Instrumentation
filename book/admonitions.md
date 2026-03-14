# Admonitions

This page lists the standard admonition types supported by Jupyter Book and examples of custom admonitions used in this book. Each example shows the source code first and then the rendered admonition.

## Standard admonition types

### Note

````markdown
```{note}
This is a note.
```
````

```{note}
This is a note.
```

### Warning

````markdown
```{warning}
This is a warning.
```
````

```{warning}
This is a warning.
```

### Important

````markdown
```{important}
This is important information.
```
````

```{important}
This is important information.
```

### Tip

````markdown
```{tip}
This is a tip.
```
````

```{tip}
This is a tip.
```

### Caution

````markdown
```{caution}
This is a caution.
```
````

```{caution}
This is a caution.
```

### Attention

````markdown
```{attention}
This is an attention box.
```
````

```{attention}
This is an attention box.
```

### Error

````markdown
```{error}
This is an error box.
```
````

```{error}
This is an error box.
```

### Danger

````markdown
```{danger}
This is a danger box.
```
````

```{danger}
This is a danger box.
```

### See also

````markdown
```{seealso}
See also: related content.
```
````

```{seealso}
See also: related content.
```

### Hint

````markdown
```{hint}
This is a hint.
```
````

```{hint}
This is a hint.
```

### Generic admonition (custom title)

````markdown
```{admonition} Custom title
This is a custom admonition using the generic directive.
```
````

```{admonition} Custom title
This is a custom admonition using the generic directive.
```

## Custom admonitions used in this book

These are built with the generic `admonition` directive plus a custom title and optional classes.

### Interactive page (warning + dropdown)

````markdown
```{admonition} Interactive page
:class: warning, dropdown
This page contains interactive elements.
```
````

```{admonition} Interactive page
:class: warning, dropdown
This page contains interactive elements.
```

### AI tip (note)

````markdown
```{admonition} AI tip
:class: ai
Use AI tools to help debug, but verify the results.
```
````

```{admonition} AI tip
:class: ai
Use AI tools to help debug, but verify the results.
```

### Solution to this exercise (dropdown)

````markdown
```{admonition} Solution to this exercise
:class: dropdown
A worked solution appears here.
```
````

```{admonition} Solution to this exercise
:class: dropdown
A worked solution appears here.
```

### How to use this book (note + dropdown)

````markdown
```{admonition} How to use this book?
:class: note, dropdown
Guidance on how to navigate the material.
```
````

```{admonition} How to use this book?
:class: note, dropdown
Guidance on how to navigate the material.
```
