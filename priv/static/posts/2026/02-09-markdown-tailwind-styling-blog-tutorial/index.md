%{
  title: "How to style markdown using tailwind V4",
  author: "Brian Hammer",
  tags: ~w(markdown frontend tailwind styling),
  description: "Styling markdown generated content using tailwind classes, complete with an example.",
  image_url: "./blog-thumbnail.png",
  read_time: 15,
  hidden?: false
}
---

## The Problem

Markdown generators often translate the file directly into HTML components, but without any classes assigned by default. This is a problem with Tailwind as classes are used to directly style each element. 

One solution is to assign classes to each element by the markdown generators documentation or by custom code, but this adds *lots of complexity.* Another problem with this approach is you must ensure tailwind will not purge any of the classes assigned to the elements.

**There is a better way.**

## The Solution

One solution that adds little complexity is to use the power of CSS combined with Tailwind utility classes. This can be done with Tailwind's *@apply* feature linked below. Every component can be styled by assigning a class name at the root of where the markdown is generated, and assigning CSS classes for every type of component, as shown below:


###### Generate markdown inside an element with a specific class name. We will use 'markdown-blog' throughout this tutorial

```html
<div class="markdown-blog">
  <!-- Replace and generate your markdown below... -->
  {render_markdown_function(markdown_content)}
</div>
```

###### Style the markdown  

```css
/* Put this at the bottom of 'app.css', or in a separate file and import it  */

/* Applies to the content around markdown-blog */
.markdown-blog {
  @apply bg-black text-white text-lg;
}

/* Applies to each paragraph under 'markdown-blog' */
.markdown-blog p {
  @apply font-thin text-md mb-2 text-white;
}

/* Applies to every h1 header generated under 'markdown-blog' */
.markdown-blog h1 {
  @apply font-bold text-5xl mb-8 text-emerald-500;
}
/*
...repeat for every possible markdown element
*/
```

We will go over styling **every** markdown element that can be generated (that I know of). There will be a complete cheat-sheet at the bottom!

### Setup

Every framework is different and getting Markdown to generate into HTML is outside of the scope of this course. Be sure that your Markdown file is generating properly and that your element using 'markdown-blog' is exactly **ONE element** between *all* the paragraphs generated. 

Once the unstyled markdown is generated, verify the structure is right by going into inspect element. Using the Markdown listed below, your content should look like this:

[Markdown Sample Used](https://onlinemarkdown.com/)

![Correct inspect-element structure](./good-inspect-element.png)

###### I replaced the 'div' with 'section' as the root to be more semantically correct

```html
<section class="markdown-blog">
  <!-- Generate your markdown here... -->
</section>
```

### Styling Elements

By using inspect element, you can style each rendered HTML element based on its position or its tag name from its root 'markdown-blog'. 








### Complete Markdown Styles


```css
/* 
 * COLOR SYSTEM (Easily replaceable):
 * - Primary: blue-600
 * - Secondary: slate-700  
 * - Accent: amber-500
 * - Base: white/slate-50
 * - Surface: slate-100/200
 * - Border: slate-200
 * - Code bg: slate-800
 * - Code text: slate-100
 * 
 * 🎨 To customize: Find/replace these color values with your own palette
 * ...or plug me into your favorite LLM - it is very good at doing that.
 */

.markdown-blog {
  @apply text-base text-slate-700 leading-relaxed;
}

/* === TYPOGRAPHY HIERARCHY === */
/* Clean, no gradients. Just weight, size, and color. */

.markdown-blog h1 {
  @apply font-bold text-4xl md:text-5xl mb-6 text-blue-600 tracking-tight;
}

.markdown-blog h2 {
  @apply font-bold text-3xl md:text-4xl mb-4 text-blue-600 tracking-tight;
}

.markdown-blog h3 {
  @apply font-bold text-2xl md:text-3xl mb-3 text-slate-800;
}

.markdown-blog h4 {
  @apply font-bold text-xl md:text-2xl mb-3 text-slate-800;
}

.markdown-blog h5 {
  @apply font-semibold text-lg md:text-xl mb-2 text-slate-700;
}

.markdown-blog h6 {
  @apply font-semibold text-base md:text-lg mb-2 text-slate-600 uppercase tracking-wide;
}

/* === TEXT ELEMENTS === */
/* Subtle emphasis. No distracting gradients. */

.markdown-blog p {
  @apply mb-5 leading-relaxed;
}

.markdown-blog strong {
  @apply font-semibold text-slate-900;
}

.markdown-blog em {
  @apply italic text-amber-700 not-italic;  /* Wait—this is wrong. Let me fix: */
}
.markdown-blog em {
  @apply italic text-amber-700;
}

/* === LINKS === */
/* Standard underline on hover, distinct color */

.markdown-blog a {
  @apply text-blue-600 font-medium no-underline hover:underline hover:text-blue-800 transition-colors;
}

/* === LISTS === */
/* Consistent spacing, clean bullets */

.markdown-blog ul,
.markdown-blog ol {
  @apply my-5 pl-6 space-y-2;
}

.markdown-blog ul {
  @apply list-disc;
}

.markdown-blog ol {
  @apply list-decimal;
}

.markdown-blog li {
  @apply my-1;
}

.markdown-blog li > ul,
.markdown-blog li > ol {
  @apply my-1 ml-4;
}

/* === CODE & PRE === */
/* High contrast, readable monospace, no card cruft */

.markdown-blog code {
  @apply font-mono text-sm bg-slate-100 text-slate-800 px-1.5 py-0.5 rounded border border-slate-200;
}

.markdown-blog pre {
  @apply bg-slate-800 text-slate-100 p-5 rounded-lg my-6 overflow-x-auto border-0;
}

.markdown-blog pre code {
  @apply bg-transparent text-inherit p-0 border-0 text-sm leading-relaxed;
}

/* === BLOCKQUOTES === */
/* Subtle left border, muted text */

.markdown-blog blockquote {
  @apply border-l-4 border-slate-300 pl-5 my-6 text-slate-600 italic;
}

/* === IMAGES === */
/* Simple rounded corners, responsive */

.markdown-blog img {
  @apply rounded-lg my-8 max-w-full h-auto border border-slate-200;
}

/* === TABLES === */
/* Clean, minimal borders, subtle zebra striping */

.markdown-blog table {
  @apply w-full my-8 text-sm border-collapse;
}

.markdown-blog th {
  @apply bg-slate-100 text-slate-700 font-semibold p-3 text-left border border-slate-200;
}

.markdown-blog td {
  @apply p-3 border border-slate-200;
}

.markdown-blog tr:nth-child(even) {
  @apply bg-slate-50;
}

/* === HORIZONTAL RULES === */
/* Barely there */

.markdown-blog hr {
  @apply my-12 border-t border-slate-200;
}

/* === UTILITY COMPONENTS === */
/* Converted DaisyUI .alert and .btn to vanilla Tailwind */

.markdown-blog .alert {
  @apply bg-amber-50 border border-amber-200 text-amber-800 p-4 rounded-lg my-6;
}

.markdown-blog .btn {
  @apply inline-block bg-blue-600 hover:bg-blue-700 text-white font-medium px-5 py-2.5 rounded-lg transition-colors no-underline;
}

.markdown-blog .btn:hover {
  @apply no-underline; /* Override link hover underline */
}
```