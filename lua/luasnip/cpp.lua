return {
    require("luasnip").snippet(
        {trig="cmt",snippetType="snippet",desc="set up a quick doxygen comment block"},
            fmt(
                [[
                /*!
                <>
                */
                ]],
            { i(1) },
            { delimiters = "<>"}
            )
        ),

    require("luasnip").snippet(
        {trig="maincpp", snippetType="snippet", dscr="set up a bare-bones int main with some includes"},
        fmt(
            [[
            #include <cmath>
            #include <iostream>
            #include <fstream>
            #include <sstream>
            #include <iomanip>

            int main(int argc, char*argv[])
            {
                int c;
    
                double x = 0.0;
                while((c=getopt(argc,argv,"n:")) != -1)
                    switch(c)
                        {
                        case 'n': x = atof(optarg); break;
                        case '?':
                            if(optopt=='c')
                                std::cerr<<"Option -" << optopt << "requires an argument.\n";
                            else if(isprint(optopt))
                                std::cerr<<"Unknown option '-" << optopt << "'.\n";
                            else
                                std::cerr << "Unknown option character.\n";
                            return 1;
                        default:
                           abort();
                        };
                printf("x = %f\n",x);
                89
            
                return 0;
            };
            ]],
            { i(1) },
            { delimiters = "89"}
            )
        ),


}
