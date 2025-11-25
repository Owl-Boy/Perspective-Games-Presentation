#import "@preview/touying:0.6.1": *
#import "modules/dewdrop.typ": *

#import "modules/Box.typ" : fancy_box

#let slides( author:[Author], title:[Title], subtitle:[Subtitle], user_inp ) = {

  import "@preview/touying:0.6.1": *
    
  set text(font: "lato")

  show: dewdrop-theme.with(
    aspect-ratio: "16-9",
    footer: self => self.info.title,
    navigation: "mini-slides",  
    mini-slides: (
      height: 3em,
      x: 2em,
      display-section: false,
      display-subsection: true,
      linebreaks: false,
      short-heading: true,
    ),
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: datetime.today(),
      institution: [Chennai Mathematical Institute],
    ),
    config-colors(
      neutral-darkest: rgb("#000000"),
      neutral-dark: rgb("#202020"),
      neutral-light: rgb("#f3f3f3"),
      neutral-lightest: rgb("#ffffff"),
      primary: rgb("#003f88"),
      primary-light: rgb("#2159a5"),
      primary-lightest: rgb("#f2f4f8"),
    )
  )

  set text(size: 20pt)

  user_inp
}


#let quote_colour = color.linear-rgb(40%,27%,27%)

#let rule(sub: none , body ) = {
    fancy_box( 
        colour : rgb("#2159a5"), 
        symbol : $bar.v.o$ , 
        title : sub, 
        fancy_title_size : 1em , 
        label_prefix : "quote of" , 
        outlined : false,
        body 
    )
}

#let spread-list(n: 2, dir: ltr, it) = {
  let args = it.fields()
  let children = if it.has("children") {
    it.children
  } else {
    ()
  }
  if children.len() <= 1 {
    return it
  }
  args.remove("children")
  let rearrange(arr) = {
    if dir == ltr {
      return arr
    }
    if dir == ttb {
      let rows = calc.ceil(arr.len() / n)
      return range(0, rows).map(i => range(0, n).map(j => arr.at(j * rows + i, default: none))).flatten()
    }
  }
  return grid(
    columns: (100% / n,) * n,
    row-gutter: if args.tight {
      0.65em // Default value of par.leading
    } else {
      1em // Not accurate
    },
    ..rearrange(children).map(x => {
      if x != none {
        list(x, ..args)
      }
    })
  )
  repr(it)
}

#let multi-col(n : 1, body) = {
    box[
        #show list: spread-list.with(n: 2, dir: ttb)
        #body
    ]

}
