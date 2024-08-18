--the filetype.lua name of the file means these snippets will be available in filetype. Hence, here: any .tex file will see these

    -- this file first describes snippets for equations, figures, environments... 
    -- after that are a bunch of greek letter autosnippets 
    -- at the bottom is a template for a blank new PRL-style document
return {
    require("luasnip").snippet(
        {trig="eq", snippetType="snippet", dscr="A LaTeX equation environment"},
        fmta(
            [[
            \begin{equation}
                <>
            \end{equation}
            
            ]],
            { i(1) }
        )
    ),

    require("luasnip").snippet(
        {trig="fig", snippetType="snippet", dscr="A basic figure environment"},
        fmta(
            [[
            \begin{figure}
            \centerline
            \includegraphics[width=1.0\linewidth]{<>}
            \caption{\label{fig:<>}
                <>
                }
            \end{figure}

            ]],
            { i(1,"filename"),
              i(2,"figureLabel"),
              i(3, "captionText"),
             }
        )
    ),

    require("luasnip").snippet(
        {trig="env", snippetType="snippet", dscr="Begin and end an arbitrary environment"},
        fmta(
            [[
            \begin{<>}
                <>
            \end{<>}

            ]],
            {i(1),
             i(2),
             rep(1),
            }
        )
    ),

    require("luasnip").snippet(
        {trig="cases", snippetType="snippet", dscr="Set up a case statement (requires amsmath)"},
        fmta(
            [[
            \begin{cases}
                <> & \text{<> $<>$} \\
                <> & \text{<> $<>$}
            \end{cases}
            ]],
            {i(1,"0"),
             i(2,"if"),
             i(3,"x<0"),
             i(4,"1"),
             i(5,"if"),
             i(6,"x>0"),
            }
        )
    ),

    require("luasnip").snippet(
        {trig="mat", snippetType="snippet", dscr="Set up a 2x2 matrix (requires amsmath)"},
        fmta(
            [[
            \begin{pmatrix}
                <> & <> \\
                <> & <> 
            \end{pmatrix}

            ]],
            {i(1),
             i(2),
             i(3),
             i(4),
            }
        )
    ),

    require("luasnip").snippet(
        {trig="href", snippetType="snippet", dscr="href with placeholders to remind you of the order"},
        fmta(
            [[\href{<>}{<>}]],
            {
            i(1, "url"),
            i(2, "display name"),
            }
        )
    ),


    --autotrigger greek letters
    s({trig=";a", snippetType="autosnippet", desc="alpha"},
        {
            t("\\alpha"),
        }
    ),
    s({trig=";b", snippetType="autosnippet", desc="beta"},
        {
            t("\\beta"),
        }
    ),
    s({trig=";B", snippetType="autosnippet", desc="Beta"},
        {
            t("\\Beta"),
        }
    ),
    s({trig=";g", snippetType="autosnippet", desc="gamma"},
        {
            t("\\gamma"),
        }
    ),
    s({trig=";G", snippetType="autosnippet", desc="Gamma"},
        {
            t("\\Gamma"),
        }
    ),
    s({trig=";d", snippetType="autosnippet", desc="delta"},
        {
            t("\\delta"),
        }
    ),
    s({trig=";D", snippetType="autosnippet", desc="Delta"},
        {
            t("\\Delta"),
        }
    ),
    s({trig=";e", snippetType="autosnippet", desc="eta"},
        {
            t("\\eta"),
        }
    ),
    s({trig=";z", snippetType="autosnippet", desc="zeta"},
        {
            t("\\zeta"),
        }
    ),
    s({trig=";t", snippetType="autosnippet", desc="theta"},
        {
            t("\\theta"),
        }
    ),
    s({trig=";p", snippetType="autosnippet", desc="pi"},
        {
            t("\\pi"),
        }
    ),
    s({trig=";r", snippetType="autosnippet", desc="rho"},
        {
            t("\\rho"),
        }
    ),
    s({trig=";s", snippetType="autosnippet", desc="sigma"},
        {
            t("\\sigma"),
        }
    ),
    s({trig=";o", snippetType="autosnippet", desc="omega"},
        {
            t("\\omega"),
        }
    ),
    s({trig=";w", snippetType="autosnippet", desc="omega"},
        {
            t("\\omega"),
        }
    ),
    s({trig=";O", snippetType="autosnippet", desc="Omega"},
        {
            t("\\Omega"),
        }
    ),



    --create, for convenience, a compilable template
    s({trig="blankTemplate", snippetType="snippet", dscr="Set up a bare-bones article"},
        fmta(
            [[
            \documentclass[]{article}
            \usepackage{amsmath}

            %opening
            \title{<>}
            \author{<>}

            \begin{document}

            \maketitle


            <>

            \end{document}
            ]],
            { 
              i(1,"Title goes here"),
              i(2,"Author name"),
              i(3,"Start typing!"),
            }
        )
    ),
    --a template with prl-like stylings
    s({trig="prlTemplate", snippetType="snippet", dscr="set up a new default Phys-Rev-style LaTeX template"},
        fmta(
            [[
            \documentclass[aps,preprint,superscriptaddress,nofootinbib, notitlepage,prl]{revtex4-2}

            \usepackage[utf8]{inputenc}
            \usepackage{graphicx}
            \usepackage[dvipsnames,x11names]{xcolor}
            \usepackage{float}
            \usepackage{mathrsfs}
            \usepackage{amsmath,amssymb}
            \usepackage{hyperref}


            \newcommand{\dms}[1]{{\color{blue} #1}}

            %\bibliographystyle{unsrt}


            \begin{document}

            \title{<>}

            \author{Daniel M. Sussman}\email{daniel.m.sussman@emory.edu}
            \affiliation{Department of Physics, Emory University, Atlanta, GA, USA}

            \date{\today}

            \begin{abstract}
            <>
            \end{abstract}

            \maketitle

            \section{Introduction}

            intro text

            \section{Methods}

            methods text

            \section{Results}

            results text

            \section{Discussion}

            discussion text

            %\bibliography{<>}


            \end{document}
            ]],
            { i(1,"Title goes here"),
              i(2,"An extremely good abstract"),
              i(3,"bibliographyFileName"),
            }
        )
    ),

}
