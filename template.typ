#import "metadata.typ": *

#let slides(doc) = {
	// Variables for configuration.
	let scale = 2cm
	let width = beamer_format.at(0) * scale
	let height = beamer_format.at(1) * scale
	
	// Setup.
	set document(
		title: presentation_title,
		author: author,
	)
	set text(
		font: font,
		size: 25pt,
	)
	set page(
		width: width,
		height: height,
		margin: 0pt,
	)
	set align(center + horizon)
	
	show heading: title => {
		pagebreak(weak: true)
		rect(width: 100%, height: 100%, fill: theme_background, text(fill: theme_text, title))
		pagebreak(weak: true)
	}
	
	// Title page.
	rect(width: 100%, height: 100%, fill: theme_background, {
		set text(fill: theme_text)
		text(size: 50pt, weight: "bold", presentation_title)
		linebreak()
		text(size: 30pt, presentation_subtitle)
		v(2em)
		text(size: 25pt, author)
	})
	pagebreak(weak: true)
	
	// Actual content.
	doc
}

#let slide(title: "Chapter", content) = locate(loc => {
	// Header with slide title.
	let header = {
		let headers = query(selector(heading).before(loc), loc)
		set align(left + top)
		set text(fill: theme_text, weight: "bold")
		rect(width: 100%, fill: theme_background, pad(x: 10pt, y: 10pt)[
			#if headers == () {
				text(size: 30pt, title)
			} else {
				let section = headers.last().body
				text(size: 15pt, section)
				linebreak()
				text(size: 25pt, title)
			}
		])
	}
	
	// Footer with left and right section.
	let footer = grid(columns: (1fr, auto), pad(x: 5pt, y: 8pt)[
		// Presentation title and author.
		#set align(left)
		#set text(12pt)
		#presentation_title \
		#set text(10pt)
		#author
	], [
		// Page counter.
		#rect(
			width: 60pt,
			height: 40pt,
			fill: theme_background,
			align(
				center + horizon,
				text(20pt, fill: theme_text, counter(page).display())
			)
		)
	])
	
	pagebreak(weak: true)
	grid(rows: (auto, 1fr, auto), {
		header
	}, {
		// Inner slide content.
		pad(x: 10pt, y: 10pt, box(align(left, content)))
	}, {
		footer
	})
	pagebreak(weak: true)
})
