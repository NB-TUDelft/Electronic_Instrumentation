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

These are built with the generic `admonition` directive plus a custom title and optional classes. Use `no-content` when you want an admonition with only a title row and no body text.

### Interactive page

````markdown
```{admonition} Interactive page
:class: interactive, dropdown
This page contains interactive elements. Press the launch button at the top right side in order to use them.
```
````

```{admonition} Interactive page
:class: interactive, dropdown
This page contains interactive elements. Press the launch button at the top right side in order to use them.
```

### Answer (note)

````markdown
```{admonition} Answer
:class: answer
Use this box to show the expected answer or solution.
```
````

```{admonition} Answer
:class: answer
Use this box to show the expected answer or solution.
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

### Estimated time

````markdown
```{admonition} Estimated time: 10 min
:class: estimated-time no-content
```
````

```{admonition} Estimated time: 10 min
:class: estimated-time no-content
```

### Deep dive (optional enrichment)

````markdown
```{admonition} Deep dive (optional)
:class: deep-dive
This section contains extra background and is not required for completing the core task.
```
````

```{admonition} Deep dive (optional)
:class: deep-dive
This section contains extra background and is not required for completing the core task.
```
