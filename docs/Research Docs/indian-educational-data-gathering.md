# Indian Educational Data Gathering

> Converted from `Indian Educational Data Gathering.pdf` (August 2026). Research feeding the onboarding data rebuild.

Data Sourcing Brief and Taxonomic
Audit for Career Navigation Systems
The integrity of a stateless, offline-first career decision system relies entirely on the absolute
fidelity of its compile-time data. The discovery that the application currently relies on fractional,
discontinued, and commercially skewed datasets presents a critical failure point in user trust
and developmental routing. The governing principle dictating this data overhaul dictates that
simulated or deprecated pathways must be aggressively pruned to prevent catastrophic
educational missteps by the student populace.
An overarching analysis of the Indian educational framework reveals a landscape currently
undergoing severe tectonic shifts. These shifts are primarily driven by the implementation of the
National Education Policy (NEP) 2020, the restructuring of state assessment boards, and the
harmonization of vocational frameworks under the National Council for Vocational Education
and Training (NCVET). To ensure the application provides genuine, actionable guidance to a
demographic ranging from Class 9 to post-graduation, the underlying taxonomy has been
completely reconstructed. This reconstruction excises coaching institute products masquerading
as official exams, clearly flags stalled governmental schemes, and introduces vital, previously
missing corridors such as diploma lateral entry and apprenticeship frameworks.
The Unified Examination Register
The examination register serves as the foundational routing mechanism for the application. A
rigorous verification process has identified several critical anomalies in the legacy dataset that
actively misguide users.
Most prominently, the National Talent Search Examination (NTSE), historically a cornerstone of
Class 10 talent identification, has not been approved beyond the March 2021 cycle by the
Ministry of Education1. The scheme remains indefinitely stalled pending a structural revamp
intended to enhance visibility among rural students1. The NCERT explicitly confirms that the
scheme in its present form has not been approved for further implementation1. Continuing to
present the NTSE as an active pathway represents a severe systemic hazard; it has thus been
flagged with a suspended status.
Similarly, entry into the Rashtriya Indian Military College (RIMC) is strictly limited to Class 8
students within a narrow age band, rendering it an invalid suggestion for older cohorts3. The All
India Sainik Schools Entrance Examination (AISSEE) operates on strict age parameters for
Class 6 (10-12 years) and Class 9 (13-15 years) entry, making it inaccessible beyond those
stages4.
Furthermore, the register now incorporates lateral entry examinations, which represent the
primary upward mobility vector for diploma holders seeking engineering degrees. The absence
of state-level lateral entry tests (such as OJEE Lateral Entry, AP POLYCET, and TS POLYCET)
previously severed the digital progression of vocational students6.
The data presented in the tables below fulfills Deliverable 1 and is structured as the
CSV-equivalent data source for direct compilation into Dart map keys.
Secondary School and Military Entry Examinations


 id     ful   co     st    le    ap     eli   ca     re    ty     att   of    so   la    D
        lN    nd     at    ve    pli    gi    te     gi    pi     e     fic   ur   st    es
        a     uc     us    l     ca     bil   go     st    ca     m     ial   ce   Ve    cri
        m     tin                bl     ity   ry     ra    lW     pt    Ur    Ur   rif   pti
        e     g                  eS           R      tio   in     sP    l     l    ie    on
              B                  ta           el     nF    do     er               d     (F
              od                 ge           ax     ee    w      Ye               At    or
              y                  s            ati                 ar                     15
                                              on                                         yo
                                              s                                          )

                                                                              1
 ex     N     N      su    na    cl     10    S      ne    su     1     nc         20    C
 a      ati   C      sp    tio   as     th    C/     ed    sp           ert        26    urr
 m      on    E      en    na    s1     st    S      sV    en           .ni        -0    en
 _n     al    R      de    l     0      an    T/     eri   de           c.i        8-    tly
 ts     Ta    T      d                  da    P      fic   d            n          03    pa
 e      le           (2                 rd    H      ati                                 us
        nt           02                 en    mi     on                                  ed
        Se           1)                 rol   ni     :                                   by
        ar                              le    m      tru                                 th
        ch                              d.    u      e                                   e
        Ex                              Sc    m      (S                                  go
        a                               he    qu     us                                  ve
        mi                              m     ali    pe                                  rn
        na                              e     fyi    nd                                  m
        tio                             st    ng     ed                                  en
        n                               all   m      )                                   t.
                                        ed    ar                                         It
                                        a     ks                                         us
                                        w     at                                         ed
                                        ait   35                                         to
                                        in    %                                          be
                                        g                                                a
                                        M                                                m
                                        oE                                               aj
                                        re                                               or
                                        va                                               sc
                                        m                                                ho
                                 p.                                         lar
                                                                            sh
                                                                            ip
                                                                            te
                                                                            st
                                                                            for
                                                                            Cl
                                                                            as
                                                                            s
                                                                            10
                                                                            st
                                                                            ud
                                                                            en
                                                                            ts.

                                                                  10
ex   N     M    ac    na    cl   Cl    ne    ne    N    1   ed         20   A
a    ati   oE   tiv   tio   as   as    ed    ed    ov       uc         26   sc
m    on         e     na    s8   s     sV    sV    -D       ati        -0   ho
_n   al               l     ,    8     eri   eri   ec       on         8-   lar
m    M                      cl   en    fic   fic            .g         03   sh
m    ea                     as   rol   ati   ati            ov              ip
s    ns                     s9   le    on    on             .in             te
     -c                          d;    :     :              /n              st
     u                           mi    tru   tru            m               for
     m-                          ni    e     e              m               Cl
     M                           m                          s               as
     eri                         u                                          s
     t                           m                                          8
     Sc                          55                                         st
     ho                          %                                          ud
     lar                         m                                          en
     sh                          ar                                         ts
     ip                          ks                                         fro
                                 ;                                          m
                                 pa                                         go
                                 re                                         ve
                                 nt                                         rn
                                 al                                         m
                                 in                                         en
                                 co                                         t
                                 m                                          sc
                                 e                                          ho
                                 ce                                           ol
                                 ilin                                         s
                                 g.                                           to
                                                                              he
                                                                              lp
                                                                              fu
                                                                              nd
                                                                              th
                                                                              eir
                                                                              hi
                                                                              gh
                                                                              sc
                                                                              ho
                                                                              ol
                                                                              ed
                                                                              uc
                                                                              ati
                                                                              on
                                                                              .

                                                                    11
ex   In     H   ac    na    cl   Ag     ne    ne    N    1   hb          20   A
a    di     B   tiv   tio   as   e      ed    ed    ov       cs          26   to
m    an     C   e     na    s9   cri    sV    sV    -J       e.t         -0   ug
_i   Ol     S         l     ,    ter    eri   eri   an       ifr.        8-   h
oq   y      E               cl   ia     fic   fic            re          03   sci
js   m                      as   sp     ati   ati            s.i              en
     pi                     s1   ec     on    on             n                ce
     ad                     0    ifi    :     :                               co
     Q                           ed     tru   tru                             m
     ua                          an     e     e                               pe
     lifi                        nu                                           titi
     er                          all                                          on
     in                          y;                                           th
     Ju                          sci                                          at
     ni                          en                                           se
     or                          ce                                           le
     Sc                          pr                                           ct
     ie                          ofi                                          s
     nc                          ci                                           th
     e                           en                                           e
                                 cy.                                          be
                                                                              st
                                                                            st
                                                                            ud
                                                                            en
                                                                            ts
                                                                            to
                                                                            re
                                                                            pr
                                                                            es
                                                                            en
                                                                            t
                                                                            In
                                                                            di
                                                                            a
                                                                            int
                                                                            er
                                                                            na
                                                                            tio
                                                                            na
                                                                            lly.

                                                                   3
ex    RI    U    ac    na    cl   St    ne    ne    Ju   2   ri        20   Th
a     M     P    tiv   tio   as   ric   ed    ed    n,       m         26   e
m     C     S    e     na    s8   tly   sV    sV    D        c.        -0   en
_ri   En    C          l          Cl    eri   eri   ec       go        8-   try
m     tra   /                     as    fic   fic            v.i       03   te
c     nc    RI                    s     ati   ati            n              st
      e     M                     8     on    on                            for
      Ex    C                     st    :     :                             a
      a                           ud    tru   tru                           pr
      mi                          en    e     e                             es
      na                          ts;                                       tig
      tio                         na                                        io
      n                           rro                                       us
                                  w                                         mi
                                  ag                                        lit
                                  e                                         ar
                                  li                                        y
                                  mi                                        sc
                                  ts                                        ho
                                  ap                                        ol,
                                  pl                                        bu
                                                                            t
                                  y.                                      yo
                                                                          u
                                                                          ca
                                                                          n
                                                                          on
                                                                          ly
                                                                          ta
                                                                          ke
                                                                          it
                                                                          w
                                                                          hil
                                                                          e
                                                                          yo
                                                                          u
                                                                          ar
                                                                          e
                                                                          in
                                                                          Cl
                                                                          as
                                                                          s
                                                                          8.

                                                                 4
ex    All   N    ac    na    cl   Ag   ne    G    Ja   1   ex        20   Th
a     In    TA   tiv   tio   as   e    ed    en   n-       a         26   e
m     di         e     na    s8   13   sV    /O   Fe       m         -0   ex
_a    a                l     ,    -1   eri   B    b        s.        8-   a
iss   Sa                     cl   5    fic   C:            nt        03   m
ee    ini                    as   ye   ati   Rs            a.             to
_9    k                      s9   ar   on    80            ac             ge
      Sc                          s    :     0,            .in            t
      ho                          as   tru   S             /AI            int
      ol                          of   e     C/            S              o
      s                           M          S             S              a
      En                          ar         T:            E              Sa
      tra                         ch         Rs            E              ini
      nc                          31         65                           k
      e                           ;          0                            Sc
      Ex                          Cl                                      ho
      a                           as                                      ol
      m                           s                                       for
      (C                          8                                       Cl
      la                          pa                                      as
      ss                           ss                                            s
      IX                           ed                                            9,
      )                            .                                             le
                                                                                 ad
                                                                                 in
                                                                                 g
                                                                                 to
                                                                                 w
                                                                                 ar
                                                                                 d
                                                                                 a
                                                                                 ca
                                                                                 re
                                                                                 er
                                                                                 in
                                                                                 th
                                                                                 e
                                                                                 ar
                                                                                 m
                                                                                 ed
                                                                                 for
                                                                                 ce
                                                                                 s.

Polytechnic, Lateral Entry, and Vocational Pathways


 id   ful   co    st    le   ap    eli   ca    re    ty   att   of    so   la    D
      lN    nd    at    ve   pli   gi    te    gi    pi   e     fic   ur   st    es
      a     uc    us    l    ca    bil   go    st    ca   m     ial   ce   Ve    cri
      m     tin              bl    ity   ry    ra    lW   pt    Ur    Ur   rif   pti
      e     g                eS          R     tio   in   sP    l     l    ie    on
            B                ta          el    nF    do   er               d     (F
            od               ge          ax    ee    w    Ye               At    or
            y                s           ati              ar                     15
                                         on                                      yo
                                         s                                       )

                                                                      8
 ex   An    S     ac    st   cl    Cl    ne    ne    Ap   1     po         20    Th
 a    dh    B     tiv   at   as    as    ed    ed    r-         lyc        26    e
 m    ra    T     e     e    s1    s     sV    sV    M          et         -0    en
 _a   Pr    E                      10    eri   eri              ap         8-    tra
p_    ad    T              0    pa    fic   fic   ay       .ni       03   nc
po    es    A                   ss    ati   ati            c.i            e
lyc   h     P                   ed    on    on             n              ex
et    Po                        /a    :     :                             a
      lyt                       pp    tru   tru                           m
      ec                        ea    e     e                             for
      hn                        rin                                       3-
      ic                        g;                                        ye
      C                         mi                                        ar
      o                         ni                                        en
      m                         m                                         gi
      m                         u                                         ne
      on                        m                                         eri
      En                        35                                        ng
      tra                       %                                         di
      nc                        m                                         pl
      e                         ar                                        o
      Te                        ks                                        m
      st                        .                                         as
                                                                          in
                                                                          An
                                                                          dh
                                                                          ra
                                                                          Pr
                                                                          ad
                                                                          es
                                                                          h
                                                                          rig
                                                                          ht
                                                                          aft
                                                                          er
                                                                          Cl
                                                                          as
                                                                          s
                                                                          10
                                                                          .

                                                                 7
ex    Te    S   ac    st   cl   Cl    ne    ne    Ap   1   po        20   Th
a     la    B   tiv   at   as   as    ed    ed    r-       lyc       26   e
m     ng    T   e     e    s1   s     sV    sV    M        et.       -0   te
_t    an    E              0    10    eri   eri   ay       sb        8-   st
s_    a     T                   pa    fic   fic            tet            to
po    St    T                   ss    ati   ati            .te       03   en
lyc   at    S                   ed    on    on             la             ter
et    e                         /a    :     :              ng             a
      Po                        pp    tru   tru            an             po
      lyt                       ea    e     e              a.             lyt
      ec                        rin                        go             ec
      hn                        g;                         v.i            hn
      ic                        m                          n              ic
      C                         at                                        co
      o                         he                                        lle
      m                         m                                         ge
      m                         ati                                       for
      on                        cs                                        an
      En                        ,                                         en
      tra                       sci                                       gi
      nc                        en                                        ne
      e                         ce                                        eri
      Te                        fo                                        ng
      st                        cu                                        di
                                s.                                        pl
                                                                          o
                                                                          m
                                                                          a
                                                                          in
                                                                          Te
                                                                          la
                                                                          ng
                                                                          an
                                                                          a.

                                                                 7
ex    Jo    W   ac    st   cl   Cl    ne    ne    M    1   w         20   W
a     int   B   tiv   at   as   as    ed    ed    ay       eb        26   es
m     En    S   e     e    s1   s     sV    sV             sc        -0   t
_j    tra   C              0    10    eri   eri            te.       8-   Be
ex    nc    T                   pa    fic   fic            co        03   ng
po    e     E                   ss    ati   ati            .in            al'
      Ex                        ed    on    on                            s
      a                         /a    :     :                             m
      mi                        pp    tru   tru                           ai
      na                        ea    e     e                             n
      tio                       rin                                       ex
      n                         g                                         a
     for                         in                                        m
     Po                          W                                         for
     lyt                         es                                        en
     ec                          t                                         ter
     hn                          Be                                        in
     ics                         ng                                        g
                                 al.                                       di
                                                                           pl
                                                                           o
                                                                           m
                                                                           a
                                                                           co
                                                                           ur
                                                                           se
                                                                           s
                                                                           in
                                                                           en
                                                                           gi
                                                                           ne
                                                                           eri
                                                                           ng
                                                                           an
                                                                           d
                                                                           te
                                                                           ch
                                                                           no
                                                                           lo
                                                                           gy
                                                                           .

                                                                  6
ex   O     O    ac    st   di    Di    ne    ne    M    1   oj        20   An
a    di    JE   tiv   at   pl    pl    ed    ed    ay       ee        26   ex
m    sh    E    e     e    o     o     sV    sV    -J       .ni       -0   a
_o   a     Bo              m     m     eri   eri   un       c.i       8-   m
je   Jo    ar              a,    a     fic   fic            n         03   for
e_   int   d               iti   in    ati   ati                           di
le   En                          En    on    on                            pl
     tra                         gi    :     :                             o
     nc                          ne    tru   tru                           m
     e                           eri   e     e                             a
     Ex                          ng                                        st
     a                           /T                                        ud
     mi                            ec                                           en
     na                            hn                                           ts
     tio                           ol                                           in
     n                             og                                           O
     (L                            y;                                           di
     at                            mi                                           sh
     er                            ni                                           a
     al                            m                                            to
     En                            u                                            ju
     try                           m                                            m
     )                             pe                                           p
                                   rc                                           dir
                                   en                                           ec
                                   ta                                           tly
                                   ge                                           int
                                   .                                            o
                                                                                th
                                                                                e
                                                                                se
                                                                                co
                                                                                nd
                                                                                ye
                                                                                ar
                                                                                of
                                                                                a
                                                                                B.
                                                                                Te
                                                                                ch
                                                                                de
                                                                                gr
                                                                                ee
                                                                                .

                                                                      13
sc   N     M    ac    na    iti,   Ba    ne    N     Ye    N/   ap         20   N
he   ati   S    tiv   tio   cl     sic   ed    on    ar-   A    pr         26   ot
m    on    D    e     na    as     ed    sV    e     ro         en         -0   an
e_   al    E/         l     s1     uc    eri   (S    un         tic        8-   ex
na   Ap    N                0      ati   fic   tip   d          es         03   a
ps   pr    C                       on    ati   en               hi              m,
     en    V                       al    on    d                pi              bu
     tic   E                       qu    :     pr               nd              ta
     es                            ali   tru   ov               ia.             go
     hi    T                     fic   e     id               go              ve
     p                           ati         ed               v.i             rn
     Pr                          on          )                n               m
     o                           m                                            en
     m                           at                                           t
     oti                         ch                                           sc
     on                          in                                           he
     Sc                          g                                            m
     he                          tra                                          e
     m                           de                                           th
     e                           cri                                          at
                                 ter                                          pa
                                 ia.                                          ys
                                                                              yo
                                                                              u
                                                                              a
                                                                              sti
                                                                              pe
                                                                              nd
                                                                              to
                                                                              le
                                                                              ar
                                                                              n
                                                                              on
                                                                              -th
                                                                              e-j
                                                                              ob
                                                                              ski
                                                                              lls
                                                                              in
                                                                              a
                                                                              co
                                                                              m
                                                                              pa
                                                                              ny
                                                                              .

                                                                    15
sc   N     M    ac    na    di   D     ne    N     Ye    N/   na         20   A
he   ati   oE   tiv   tio   pl   eg    ed    on    ar-   A    ts.        26   pa
m    on         e     na    o    re    sV    e     ro         ed         -0   id
e_   al               l     m    e     eri   (S    un         uc         8-   tra
na   Ap                     a,   or    fic   tip              ati             ini
ts   pr    un    Di    ati   en   d   on    03   ng
     en    de    pl    on    d        .g         sc
     tic   rgr   o     :     pr       ov         he
     es    ad    m     tru   ov       .in        m
     hi    ua    a     e     id                  e
     p     te    ho          ed                  for
     Tr          ld          )                   st
     ai          er                              ud
     ni          s                               en
     ng          in                              ts
     Sc          en                              w
     he          gi                              ho
     m           ne                              ha
     e           eri                             ve
                 ng                              co
                 /te                             m
                 ch                              pl
                 no                              et
                 lo                              ed
                 gy                              th
                 .                               eir
                                                 di
                                                 pl
                                                 o
                                                 m
                                                 a
                                                 or
                                                 de
                                                 gr
                                                 ee
                                                 an
                                                 d
                                                 ne
                                                 ed
                                                 w
                                                 or
                                                 k
                                                 ex
                                                 pe
                                                 rie
                                                 nc
                                                                                  e.

Undergraduate, Graduate, and Professional Examinations


 id   ful   co    st    le    ap    eli   ca    re    ty   att   of    so   la    D
      lN    nd    at    ve    pli   gi    te    gi    pi   e     fic   ur   st    es
      a     uc    us    l     ca    bil   go    st    ca   m     ial   ce   Ve    cri
      m     tin               bl    ity   ry    ra    lW   pt    Ur    Ur   rif   pti
      e     g                 eS          R     tio   in   sP    l     l    ie    on
            B                 ta          el    nF    do   er               d     (F
            od                ge          ax    ee    w    Ye               At    or
            y                 s           ati              ar                     15
                                          on                                      yo
                                          s                                       )

                                                                       16
 ex   Jo    N     ac    na    cl    Cl    ne    ne    Ja   2     je         20    Th
 a    int   TA    tiv   tio   as    as    ed    ed    n,         e          26    e
 m    En          e     na    s1    s     sV    sV    Ap         m          -0    bi
 _j   tra               l     2,    12    eri   eri   r          ai         8-    gg
 ee   nc                      dr    P     fic   fic              n.         03    es
 _    e                       op    C     ati   ati              nt               t
 m    Ex                      pe    M;    on    on               a.               na
 ai   a                       r     att   :     :                ni               tio
 n    mi                            e     tru   tru              c.i              na
      na                            m     e     e                n                l
      tio                           pt                                            te
      n                             li                                            st
      (M                            mi                                            for
      ai                            ts                                            ge
      n)                            ap                                            tti
                                    pl                                            ng
                                    y                                             int
                                    (c                                            o
                                    on                                            en
                                    se                                            gi
                                    cu                                            ne
                                    tiv                                           eri
                                    e                                             ng
                                    ye                                            co
                                    ar                                            lle
                                                                                  ge
                                  s).                                        s
                                                                             lik
                                                                             e
                                                                             NI
                                                                             Ts
                                                                             ,
                                                                             an
                                                                             d
                                                                             th
                                                                             e
                                                                             fir
                                                                             st
                                                                             st
                                                                             ep
                                                                             for
                                                                             IIT
                                                                             s.

                                                                   17
ex   N      N    ac    na    cl   Cl    ne    ne    M    1   ne         20   Th
a    ati    TA   tiv   tio   as   as    ed    ed    ay       et.        26   e
m    on          e     na    s1   s     sV    sV             nt         -0   on
_n   al                l     2,   12    eri   eri            a.         8-   ly
ee   Eli                     dr   P     fic   fic            ni         03   m
t_   gi                      op   C     ati   ati            c.i             ed
ug   bili                    pe   B;    on    on             n               ic
     ty                      r    mi    :     :                              al
     cu                           ni    tru   tru                            en
     m                            m     e     e                              tra
     En                           u                                          nc
     tra                          m                                          e
     nc                           ag                                         ex
     e                            e                                          a
     Te                           17                                         m
     st                           ;                                          in
     (U                           no                                         In
     G)                           up                                         di
                                  pe                                         a
                                  r                                          for
                                  ag                                         be
                                  e                                          co
                                  li                                         mi
                                  mi                                         ng
                                  t.                                        a
                                                                            do
                                                                            ct
                                                                            or
                                                                            (M
                                                                            B
                                                                            B
                                                                            S)
                                                                            or
                                                                            de
                                                                            nti
                                                                            st
                                                                            (B
                                                                            D
                                                                            S)
                                                                            .

                                                                  18
ex   U      N    ac    na    po   Mi    50    G    Ju   2   ug         20   An
a    ni     TA   tiv   tio   st   ni    %     en   n,       cn         26   ex
m    ve          e     na    gr   m     m     :    D        et.        -0   a
_u   rsi               l     ad   u     ar    11   ec       nt         8-   m
gc   ty                      ua   m     ks    50            a.         03   ta
_n   Gr                      te   55    for   ,             ac              ke
et   an                           %     S     O             .in             n
     ts                           in    C/    B                             aft
     C                            M     S     C:                            er
     o                            as    T/    60                            a
     m                            ter   O     0,                            M
     mi                           's;   B     S                             as
     ssi                          ag    C/    C/                            ter
     on                           e     P     S                             's
     N                            li    w     T:                            de
     ati                          mi    D     32                            gr
     on                           ts          5                             ee
     al                           for                                       to
     Eli                          JR                                        be
     gi                           F                                         co
     bili                         ap                                        m
     ty                           pl                                        e
     Te                           y.                                        a
     st                                                                     co
                                                                            lle
                                                                             ge
                                                                             pr
                                                                             of
                                                                             es
                                                                             so
                                                                             r
                                                                             or
                                                                             ge
                                                                             ta
                                                                             go
                                                                             ve
                                                                             rn
                                                                             m
                                                                             en
                                                                             t
                                                                             re
                                                                             se
                                                                             ar
                                                                             ch
                                                                             gr
                                                                             an
                                                                             t.

                                                                   21
ex    Jo    N    ac    na    po   M.    ne    ne    Ju   2   csi        20   Si
a     int   TA   tiv   tio   st   Sc    ed    ed    n,       rn         26   mi
m     C     /    e     na    gr   or    sV    sV    D        et.        -0   lar
_c    SI    C          l     ad   eq    eri   eri   ec       nt         8-   to
sir   R-    SI               ua   ui    fic   fic            a.         03   U
_n    U     R                te   va    ati   ati            ac              G
et    G                           le    on    on             .in             C
      C                           nt;   :     :                              N
      N                           mi    tru   tru                            E
      E                           ni    e     e                              T,
      T                           m                                          bu
                                  u                                          t
                                  m                                          sp
                                  55                                         ec
                                  %                                          ific
                                  m                                          all
                                  ar                                         y
                                  ks                                         for
                                                                             st
                                .                                          ud
                                                                           en
                                                                           ts
                                                                           w
                                                                           ho
                                                                           st
                                                                           ud
                                                                           ie
                                                                           d
                                                                           Sc
                                                                           ie
                                                                           nc
                                                                           e
                                                                           su
                                                                           bj
                                                                           ec
                                                                           ts
                                                                           lik
                                                                           e
                                                                           Ph
                                                                           ysi
                                                                           cs
                                                                           ,
                                                                           C
                                                                           he
                                                                           mi
                                                                           str
                                                                           y,
                                                                           an
                                                                           d
                                                                           Lif
                                                                           e
                                                                           Sc
                                                                           ie
                                                                           nc
                                                                           es
                                                                           .

                                                                 23
ex   S    St   ac    na    gr   Gr    S    ne    O     1   sb         20   A
a    BI   at   tiv   tio   ad   ad    C/   ed    ct-       i.c        26   hi
m    Pr   e    e     na    ua   ua    S    sV    D         o.i        -0   gh
_s   ob   Ba                    tio   T:   eri             n/         8-   ly
bi   ati   nk   l   te   n     5y    fic   ec   ca   03   co
_p   on    of            in    rs,   ati        re        m
o    ar    In            an    O     on         er        pe
     y     di            y     B     :          s         titi
     Of    a             di    C:    tru                  ve
     fic                 sci   3y    e                    te
     er                  pli   rs,                        st
     Ex                  ne    P                          to
     a                   ;     w                          be
     mi                  Ag    D:                         co
     na                  e     up                         m
     tio                 21    to                         e
     n                   -3    15                         a
                         0     yr                         ba
                         ye    s                          nk
                         ar                               m
                         s.                               an
                                                          ag
                                                          er
                                                          at
                                                          th
                                                          e
                                                          St
                                                          at
                                                          e
                                                          Ba
                                                          nk
                                                          of
                                                          In
                                                          di
                                                          a
                                                          aft
                                                          er
                                                          gr
                                                          ad
                                                          ua
                                                          tin
                                                          g
                                                          co
                                                          lle
                                                          ge
                                                                            .

                                                                  25
ex   C     U   ac    na    gr   D      ne    ne    Ap   2   up         20   An
a    o     P   tiv   tio   ad   eg     ed    ed    r,       sc         26   ex
m    m     S   e     na    ua   re     sV    sV    Se       .g         -0   a
_c   bi    C         l     te   e      eri   eri   p        ov         8-   m
ds   ne                         fro    fic   fic            .in        03   ta
     d                          m      ati   ati                            ke
     D                          re     on    on                             n
     ef                         co     :     :                              aft
     en                         gn     tru   tru                            er
     ce                         iz     e     e                              co
     Se                         ed                                          lle
     rvi                        un                                          ge
     ce                         iv                                          to
     s                          er                                          be
     Ex                         sit                                         co
     a                          y;                                          m
     mi                         sp                                          e
     na                         ec                                          an
     tio                        ific                                        off
     n                          ag                                          ic
                                es                                          er
                                pe                                          in
                                r                                           th
                                ac                                          e
                                ad                                          Ar
                                e                                           m
                                m                                           y,
                                y.                                          N
                                                                            av
                                                                            y,
                                                                            or
                                                                            Air
                                                                            Fo
                                                                            rc
                                                                            e.

                                                                  3
ex   N     U   ac    na    cl   Cl     ne    ne    Ap   2   up         20   Th
a    ati   P   tiv   tio   as   as     ed    ed    r,       sc         26   e
m    on    S   e     na    s1   s      sV    sV    Se       .g         -0   ex
_n   al   C   l   2,   12    eri   eri   p   ov    8-   a
da   D            dr   ap    fic   fic       .in   03   m
_n   ef           op   pe    ati   ati                  to
a    en           pe   ari   on    on                   joi
     ce           r    ng    :     :                    n
     Ac                /p    tru   tru                  th
     ad                as    e     e                    e
     e                 se                               mi
     m                 d;                               lit
     y                 un                               ar
     &                 m                                y
     N                 arr                              str
     av                ie                               ai
     al                d;                               gh
     Ac                str                              t
     ad                ict                              ou
     e                 ph                               t
     m                 ysi                              of
     y                 ca                               hi
     Ex                l                                gh
     a                 st                               sc
     m                 an                               ho
                       da                               ol,
                       rd                               le
                       s.                               ad
                                                        in
                                                        g
                                                        to
                                                        a
                                                        ca
                                                        re
                                                        er
                                                        as
                                                        a
                                                        co
                                                        m
                                                        mi
                                                        ssi
                                                        on
                                                        ed
                                                        off
                                                        ic
                                                                                               er.


Relational Two-Tier Interest Taxonomy
The legacy architecture featured a flat list of thirty unstructured strings. This forced users into
severe cognitive overload, artificially mixing broad industries with highly specific, jargon-heavy
job titles. For a 15-year-old student, the distinction between "Data & AI" and "Computers & IT" is
meaningless without context; it is a distinction understood only by industry insiders.
To rectify this, the taxonomy has been restructured into a two-tier relational model. The primary
clusters represent macro-fields immediately recognizable to a Class 9 demographic. Beneath
these clusters, specific interests map dynamically to the streams, subjects, and examination
pathways identified in Deliverable 1. This structure ensures that vocational and non-elite
trajectories—such as skilled trades, hospitality, and local government work—are granted parity
with elite academic routes. This directly addresses the workforce imbalances highlighted in
macroeconomic policy reports, which note that 88% of the Indian workforce operates in roles
misaligned with higher educational degrees, stressing the urgent need for visible technical and
vocational education and training (TVET) pathways27.
Macro-Cluster 1: Engineering, Making, and Skilled Trades
This cluster aggregates advanced engineering degrees and foundational industrial trades,
establishing a seamless continuum of mechanical and technical interests without stigmatizing
vocational routes.
 id           interest    stream       subject     course       exams       careerE     dayToD
              Name        s            s           s                        xample      ay
                                                                            s


 int_mec      Machin      PCM,         Mathem      B.Tech       exam_j      Mechan      Designi
 h_auto       es &        Vocatio      atics,      Mech,        ee_mai      ical        ng,
              Vehicle     nal          Physics     Diploma      n,          Enginee     repairin
              s                                    Auto,        exam_a      r, Auto     g, and
                                                   ITI          p_polyc     Mechan      testing
                                                   Fitter       et          ic          engines
                                                                                        and
                                                                                        large
                                                                                        physical
                                                                                        machin
                                                                                        es.


 int_elec     Electric    PCM,         Physics     B.Tech       exam_j      Electrici   Installin
 trical       al &        Vocatio      ,           EE, ITI      expo,       an,         g
              Wiring      nal          Mathem      Electrici    exam_o      Power       wiring,
                                      atics       an          jee_le      Grid        repairin
                                                                          Enginee     g
                                                                          r           electron
                                                                                      ics, and
                                                                                      managi
                                                                                      ng
                                                                                      power
                                                                                      systems
                                                                                      .


 int_con     Building     PCM,        Physics     B.Tech      exam_j      Civil       Plannin
 structio    &            Vocatio     ,           Civil,      ee_mai      Enginee     g
 n           Infrastru    nal         Mathem      Diploma     n,          r,          structur
             cture                    atics       Civil       exam_t      Constru     es,
                                                              s_polyc     ction       surveyi
                                                              et          Supervi     ng land,
                                                                          sor         and
                                                                                      managi
                                                                                      ng
                                                                                      building
                                                                                      sites.



Macro-Cluster 2: Healthcare, Biology, and Agriculture
This cluster merges traditional medical pathways with allied health, veterinary, and modern
agricultural sciences, reflecting a diverse ecosystem of biological careers.
 id          interest     stream      subject     course      exams       careerE     dayToD
             Name         s           s           s                       xample      ay
                                                                          s


 int_med     Human        PCB         Biology,    MBBS,       exam_n      Doctor,     Diagnos
 icine       Health                   Chemist     BDS,        eet_ug      Nurse,      ing
             &                        ry,         B.Sc                    Parame      illness,
             Medicin                  Physics     Nursing                 dic         treating
             e                                                                        patients
                                                                                      , and
                                                                                      managi
                                                                                      ng
                                                                                      health
                                                                                      crises.
 int_agri     Farming     PCB,         Biology,    B.Sc        exam_j       Agricult    Improvi
 _farmin      &           PCMB,        Agricult    Agricult    expo         ural        ng crop
 g            Agricult    Vocatio      ure         ure, ITI                 Scientis    yields,
              ure         nal                      Agro                     t, Farm     managi
                                                                            Manage      ng soil
                                                                            r           health,
                                                                                        and
                                                                                        running
                                                                                        farm
                                                                                        operatio
                                                                                        ns.



Macro-Cluster 3: Computing, Data, and Information Technology
Abstracting convoluted tech jargon into an accessible format, this cluster focuses on digital
creation, software logic, and hardware networking.
 id           interest    stream       subject     course      exams        careerE     dayToD
              Name        s            s           s                        xample      ay
                                                                            s


 int_soft     Coding      PCM          Comput      B.Tech      exam_j       Softwar     Writing
 ware         &                        er          CS,         ee_mai       e           code,
              Softwar                  Science     BCA,        n,           Develop     building
              e                        , Math      MCA         exam_u       er, App     softwar
                                                               gc_net       Designe     e
                                                                            r           applicati
                                                                                        ons,
                                                                                        and
                                                                                        solving
                                                                                        logic
                                                                                        puzzles.


 int_hard     IT &        PCM,         Comput      Diploma     exam_a       Network     Fixing
 ware_n       Network     Vocatio      er          IT, ITI     p_polyc      Admin,      comput
 et           ing         nal          Science     COPA        et           IT          ers,
                                       ,                                    Support     setting
                                       Physics                                          up
                                                                                        internet
                                                                                        network
                                                                                        s, and
                                                                                     managi
                                                                                     ng
                                                                                     servers.



Macro-Cluster 4: Governance, Defense, and Administration
Capturing the high aspiration for government service, uniformed defense, and administrative
stability within the Indian demographic.
 id          interest    stream      subject     course      exams       careerE     dayToD
             Name        s           s           s                       xample      ay
                                                                         s


 int_defe    Military    Any         Mathem      NDA,        exam_n      Army        Leading
 nse         &                       atics,      CDS,        da_na,      Officer,    troops,
             Uniform                 General     B.A/B.S     exam_c      Air         maintai
             ed                      Studies     c           ds          Force       ning
             Forces                                                      Pilot       physical
                                                                                     fitness,
                                                                                     and
                                                                                     protecti
                                                                                     ng
                                                                                     national
                                                                                     security.


 int_civil   Govern      Arts,       Political   B.A,        exam_u      IAS         Managi
 _serv       ment &      Comme       Science     B.Com,      gc_net,     Officer,    ng
             Civil       rce,        , History   B.Sc        UPSC        Local       public
             Service     Science                             (Placeh     Govt        policy,
                                                             older)      Clerk       process
                                                                                     ing
                                                                                     citizen
                                                                                     services
                                                                                     , and
                                                                                     adminis
                                                                                     trative
                                                                                     work.



Macro-Cluster 5: Commerce, Finance, and Retail
Focusing on the mechanics of money, trade, and enterprise.
 id          interest     stream      subject     course      exams       careerE     dayToD
             Name         s           s           s                       xample      ay
                                                                          s


 int_ban     Banking      Comme       Account     B.Com,      exam_s      Bank        Managi
 king_fin    &            rce         ancy,       CA,         bi_po       Manage      ng
             Account                  Econom      BBA                     r,          financial
             s                        ics                                 Account     ledgers,
                                                                          ant         auditing
                                                                                      account
                                                                                      s, and
                                                                                      advising
                                                                                      on
                                                                                      investm
                                                                                      ents.


 int_sale    Sales &      Any,        Busines     BBA,        scheme      Store       Managi
 s_retail    Retail       Vocatio     s           Diploma     _naps       Manage      ng
             Manage       nal         Studies     Retail                  r, Sales    shops,
             ment                                                         Executi     interacti
                                                                          ve          ng with
                                                                                      custom
                                                                                      ers, and
                                                                                      tracking
                                                                                      inventor
                                                                                      y.



State Boards, Subject Matrices, and NEP Reforms
The structural mapping of regional educational boards requires high precision, particularly
where governance is split between secondary and higher secondary levels. Furthermore, the
transition toward the National Education Policy (NEP) 2020 framework is altering examination
frequencies and subject rigidities.
The Changing Architecture of State Boards
A historic error in national datasets is the conflation of state board authorities. The state of
Karnataka exemplifies this complexity. Historically, Class 10 (SSLC) was governed by the
Karnataka Secondary Education Examination Board (KSEEB), while Class 11 and 12 (PUC)
were governed by the Department of Pre-University Education (DPUE). In 2022, these entities
were officially merged to form the Karnataka School Examination and Assessment Board
(KSEAB)29. The KSEAB now administers the entire secondary and higher secondary framework
and has pioneered the implementation of 'three annual examinations' (Exam 1, Exam 2, Exam
3) to replace traditional supplementary exams30.
Similarly, Andhra Pradesh maintains a strict bifurcation between the Board of Secondary
Education Andhra Pradesh (BSEAP) for Class 10 and the Board of Intermediate Education
Andhra Pradesh (BIEAP) for Class 11 and 1231. West Bengal mirrors this with the West Bengal
Board of Secondary Education (WBBSE) and the West Bengal Council of Higher Secondary
Education (WBCHSE)33.


 code          name         state        levels       officialUr   sourceUr      lastVerifi
                                                      l            l             edAt

                                                                   29
 brd_kar_      Karnatak     Karnatak     class10,     kseab.kar                  2026-08-
 kseab         a School     a            class11,     nataka.go                  03
               Examinati                 class12      v.in
               on and
               Assessm
               ent Board

                                                                   31
 brd_ap_b      Board of     Andhra       class10      bse.ap.go                  2026-08-
 seap          Secondar     Pradesh                   v.in                       03
               y
               Educatio
               n Andhra
               Pradesh

                                                                   32
 brd_ap_b      Board of     Andhra       class11,     bie.ap.go                  2026-08-
 ieap          Intermedi    Pradesh      class12      v.in                       03
               ate
               Educatio
               n Andhra
               Pradesh

                                                                   33
 brd_wb_       West         West         class10      wbbse.w                    2026-08-
 wbbse         Bengal       Bengal                    b.gov.in                   03
               Board of
               Secondar
               y
               Educatio
               n
                                                                        33
 brd_wb_        West          West          class11,      wbchse.w                    2026-08-
 wbchse         Bengal        Bengal        class12       b.gov.in                    03
                Council
                of Higher
                Secondar
                y
                Educatio
                n

                                                                        35
 brd_bih_       Bihar         Bihar         class10,      bbose.or                    2026-08-
 bbose          Board of                    class12       g                           03
                Open
                Schooling
                and
                Examinati
                on

                                                                        36
 brd_nat_       Central       National      class10,      cbse.gov.i                  2026-08-
 cbse           Board of                    class11,      n                           03
                Secondar                    class12
                y
                Educatio
                n

NEP Dual Board Exams Implementation
Following the Ministry of Education's directive aligned with the NEP 2020, the Central Board of
Secondary Education (CBSE) will institute a dual-board examination system beginning in the
2025-26 academic session36. The first examination phase will occur between mid-February and
March (specifically slated to begin the first Tuesday after February, spanning 34 days across 84
subjects), acting as the primary evaluation38. A secondary phase will be conducted in May36.
Crucially, this framework is not a semester system; both examinations cover the full curriculum,
allowing students to retain the best score across the two attempts, thereby mitigating
high-stakes pressure36. There will be no separate supplementary exams; students failing 1 to 5
subjects in the first exam are placed in an 'Improvement Category' and must take the second
exam38. The implementation of this schedule requires the application to shift from a singular
timeline assumption for CBSE students to a dual-window preparation strategy.
Rigid Subject Matrices: The West Bengal Anomaly
Relying on implicit inference to map streams to subjects produces critical routing errors for state
boards utilizing strict combinatorial sets. The West Bengal Council of Higher Secondary
Education (WBCHSE) operates on a highly specific semesterized elective matrix34. Students are
required to select three compulsory electives and one optional elective restricted strictly within
one of three defined sets34.
Under Set I (primarily Science and Technical routes), students must choose between explicitly
paired alternatives, such as deciding exclusively between Physics or Nutrition, and between
Chemistry or Geography34. Recently introduced technological fields, such as Cyber Security
(CBST) and Artificial Intelligence & Data Science (AIDS), are also strictly governed within these
sets41. Set II is explicitly curated for Commerce and Business administration, heavily featuring
Accountancy, Business Studies, and highly specific alternatives like Commercial Law versus
Statistics34. Set III encompasses the Humanities and Social Sciences41. A digital architecture
must statically enforce these rules; failure to do so will guide students toward subject
combinations that the state government actively prohibits, invalidating their registration
trajectory.


 board               stream              offeredCombi        mathOptionali       notes
                                         nations             ty


 brd_wb_wbchs        Science (Set I)     Physics OR          Yes (Can            Strict pairwise
 e                                       Nutrition;          choose              exclusionary
                                         Chemistry OR        Agriculture         combinations34
                                         Geography;          instead)            .
                                         Math OR
                                         Agriculture;
                                         Bio; CS OR
                                         Modern App
                                         OR EVS.


 brd_wb_wbchs        Commerce            Accountancy;        Yes (Through        Cannot mix
 e                   (Set II)            Business            Business Math       with core Set I
                                         Studies;            & Stats)            sciences34.
                                         Commercial
                                         Law OR Stats;
                                         Costing &
                                         Taxation.


 brd_wb_wbchs        Humanities          Pol Science         Yes (Through        Massive
 e                   (Set III)           OR Bio;             Basic Math for      flexibility but
                                         Education OR        Social              strict OR
                                         Nutrition;          Sciences)           conditions41.
                                         History OR
                                         Psych OR
                                         Stats.


Vocational Integration: ITI Trades and Diploma
Branches
Vocational education in India has historically suffered from informational asymmetry, leading to a
societal undervaluation of critical trades. The National Skills Qualification Framework (NSQF),
managed by the National Council for Vocational Education and Training (NCVET), acts as the
primary standardizing matrix, grading competencies from Level 1 (lowest complexity) to Level 8
(highest complexity)42.
The Directorate General of Training (DGT) manages the Industrial Training Institutes (ITIs),
which predominantly operate at NSQF Levels 3, 4, and 545. Integrating this data resolves the
systemic blind spot surrounding the transition from vocational training to formal higher
education, a progression heavily advocated for by NITI Aayog policy reports targeting the
optimization of India's demographic dividend27.
Industrial Training Institute (ITI) Trade Register
The application previously offered only 28 fictionalized trades. The actual DGT framework
operates over 137 NSQF aligned trades across approximately 15,000 ITIs46.


 tradeId       tradeNa       duration      entryQua      nsqfLeve      affiliatio    lateralPr
               me                          lification    l             n             ogressio
                                                                                     n


 iti_electri   Electricia    2 Years       Class 10      Level 4       NCVT /        Diploma
 cian          n                           with                        SCVT          Electrical
                                           Science/                                  Engg.47
                                           Math


 iti_fitter    Fitter        2 Years       Class 10      Level 4       NCVT /        Diploma
                                           with                        SCVT          Mechanic
                                           Science/                                  al Engg.47
                                           Math


 iti_copa      Computer      1 Year        Class 10      Level 3       NCVT /        Diploma
               Operator                                                SCVT          Computer
               & Prog.                                                               Science47
               Assistant
               (COPA)
 iti_solar_t   Solar         1 Year        Class 10     Level 3        NCVT         Associate
 ech           Technicia                   with                                     d
               n                           Science/                                 Apprentic
               (Electrical                 Math                                     eships45
               )


 iti_welder    Welder        1 Year        Class 8      Level 3        NCVT /       Specializ
                                                                       SCVT         ed
                                                                                    Apprentic
                                                                                    eships47

AICTE Diploma Branch Register
Diploma lateral entry routes represent a massive demographic flow that is currently unserved by
the app. These AICTE-recognized branches lead directly into Bachelor of Technology degrees
via state-level examinations.


 branchId        branchNa        durationSt      entryRoute       lateralRout     leadsToDe
                 me              andard                           e               gree


 dip_mech        Diploma in      3 Years         Class 10         Class 12 /      B.Tech
                 Mechanical                                       ITI Fitter (2   Mechanical6
                 Engineering                                      Yrs)


 dip_civil       Diploma in      3 Years         Class 10         Class 12 /      B.Tech
                 Civil                                            ITI             Civil6
                 Engineering                                      Draftsman
                                                                  (2 Yrs)


 dip_ee          Diploma in      3 Years         Class 10         Class 12 /      B.Tech
                 Electrical                                       ITI             Electrical6
                 Engineering                                      Electrician
                                                                  (2 Yrs)


 dip_auto        Diploma in      3 Years         Class 10         Class 12 /      B.Tech
                 Automobile                                       ITI Motor       Automobile6
                 Engineering                                      Mech (2
                                                                  Yrs)


Financial Assistance and Scholarship Telemetry
The data strategy surrounding financial aid requires transitioning away from early friction.
Collecting highly sensitive demographic and financial data during initial onboarding drastically
inflates cognitive load and attrition rates. Instead, the application must store the metadata of
available schemes and surface relevant portals just-in-time when a student explores heavily
monetized pathways.
A prominent adjustment in the federal scholarship ecosystem involves the PM Young Achievers
Scholarship Award Scheme for Vibrant India (PM YASASVI). The Ministry of Social Justice and
Empowerment previously utilized the NTA to conduct the Yasasvi Entrance Test (YET).
However, this examination has been officially discontinued and cancelled51. The selection
criteria have transitioned entirely to a meritocratic evaluation of grades secured in the 8th and
10th-grade final examinations for progression into the 9th and 11th-grade scholarship tiers
respectively51. The scholarship targets students from OBC, EBC, and DNT categories whose
parental income does not exceed Rs. 2.5 Lakhs annually, providing substantial aid ranging from
Rs. 75,000 to Rs. 1,50,00052.


 sche       sche       admin      eligibi    amou      windo      officia    sourc      lastVe
 meId       meNa       Body       lity       nt        w          lUrl       eUrl       rified
            me                                                                          At

                                                                             51
 schol_     PM         MSJ&       OBC/       75k -     Jul-Au     yet.nta               2026-
 pm_ya      YASA       E          EBC/D      1.5L      g          .ac.in                08-03
 sasvi      SVI                   NT;        p.a.
            Schola                Class
            rship                 9 or
                                  11;
                                  Incom
                                  e<
                                  2.5L;
                                  Merit
                                  based
                                  on
                                  previo
                                  us
                                  exams
                                  (YET
                                  cancel
                                  led).

                                                                             10
 schol_     Nation     MoE        Class      needs     Aug-N      schola                2026-
 nmms       al                    8          Verific   ov         rships.               08-03
            Means                 pass;      ation:               gov.in
            -cum-                 Govt      true
            Merit                 school
            Schola                ;
            rship                 Parent
                                  al
                                  incom
                                  e
                                  ceiling
                                  ;
                                  Minim
                                  um
                                  55%
                                  marks.

                                                                            10
 schol_     Post       MoMA       Minorit   Variabl    Aug-O      schola               2026-
 nsp_p      Matric                y         e          ct         rships.              08-03
 ostmat     Schola                comm                            gov.in
 ric        rships                unities
            Sche                  ; Class
            me for                11 to
            Minorit               Ph.D;
            ies                   Incom
                                  e
                                  ceiling
                                  s
                                  apply;
                                  Minim
                                  um
                                  50%
                                  marks.


Strategic Telemetry: Re-architecting the Student
Journey
The efficacy of an educational guidance system is inextricably linked to the precise timing and
psychological appropriateness of its data collection vectors. An analysis of the Indian
educational continuum dictates a fundamental redesign of the application's telemetry. The
objective is progressive profiling—requesting only the data required to facilitate the immediate
next phase of decision-making, thereby reducing cognitive load and preventing user alienation.
The initial onboarding phase is currently burdened with premature interrogations. Requesting
detailed financial income brackets, nuanced caste category delineations, and disability statuses
from a Class 9 student upon first launching the application creates unnecessary friction. These
data points do not fundamentally alter the broad career exploration phase; a student's initial
exposure to engineering, healthcare, or civil service pathways should not be algorithmically
gated by their financial status. Therefore, demographic and financial telemetry must be
aggressively deferred. This data should only be requested contextually—specifically, at the point
of action, such as when a user explicitly requests to view scholarship eligibility criteria or
attempts to calculate examination fee relaxations.
The essential data requirements mutate radically across the developmental timeline:
   1.​ Class 9 to 10: The telemetry must focus purely on board affiliation and broad,
       macro-level interests (as defined in the Two-Tier taxonomy). Understanding whether a
       student is under the WBBSE or CBSE directly informs the application of their upcoming
       structural realities, without requiring them to prematurely declare a professional
       allegiance.
   2.​ Class 11 to 12: The cognitive demands shift sharply toward structural rigidities. At this
       juncture, asking for generalized interests is entirely insufficient. The application must
       interrogate the student regarding their specific stream selection (Science, Commerce,
       Humanities, Vocational) and, critically, their exact subject combination matrices. As
       evidenced by the WBCHSE framework, failing to ask a Class 11 student about their
       specific elective subset restricts the application to rendering highly generalized and
       potentially inaccurate post-secondary guidance34. The application must map their selected
       subjects to downstream examination eligibility.
   3.​ Vocational and Diploma Routes: For students navigating the vocational corridors, the
       questioning architecture must pivot toward lateral mobility and apprenticeship readiness.
       The application currently fails to inquire about a diploma student's intent to pursue lateral
       entry into baccalaureate programs. By asking about direct second-year entry into a
       B.Tech program, the system can dynamically surface state-specific examinations like the
       OJEE Lateral Entry6. Interrogating ITI students regarding their interest in the National
       Apprenticeship Promotion Scheme (NAPS) bridges the gap between theoretical
       vocational training and immediate industrial deployment14.
   4.​ Undergraduate and Post-Graduate: Generalized questioning becomes obsolete. The
       application must ask about specific degree disciplines, graduation years, and precise
       professional aspirations. A student targeting academia must be identified early to surface
       UGC NET timelines55, while a student aiming for immediate employment in the banking
       sector must be routed toward SBI PO timelines56. The success of the application relies on
       acknowledging that a 21-year-old graduate requires fundamentally different architectural
       routing than a 15-year-old matriculant.
Telemetry Gaps and Unverified Domains
The strict mandate governing this dataset requires the explicit demarcation of unverified metrics.
Filling gaps with plausible assumptions violates the core architectural rule. During the
verification process, several explicit gaps were identified where official documentation either
obfuscates the data or delays its publication:
   ●​ Examination Fees: Registration fees for major national examinations fluctuate annually
       and are often highly stratified by exact caste and income intersections. Therefore, static
       fee data for the JEE Main, NEET UG, and SBI PO exams have been flagged as
       needsVerification: true. The application should utilize dynamic pointers to official
       notifications rather than hardcoding fluid financial requirements.
   ●​ Exact Category Relaxations: While overarching relaxations are documented (e.g., UGC
       NET offering a 5% relaxation for reserved categories, or SBI PO offering specific age
       relaxations18), granular percentage threshold differences across all state-level polytechnic
       entrance exams remain undocumented in the provided research scope and must be
       flagged for manual verification by the user at runtime.
   ●​ State-Specific Scholarship Stipends: Exact disbursement amounts for the NMMS and
       minor state schemes require annual verification against the scholarships.gov.in portal, as
       state matching funds alter the final beneficiary amounts10.
By maintaining this rigid standard of provenance, the application secures its position as a
trustless, reliable arbiter of career trajectories, ensuring no student is routed toward a
discontinued exam, a closed admission window, or a fictional coaching product.

Works cited

  1.​ Why NCERT postponed NTSE 2022? | Education News - The Indian Express,
      https://indianexpress.com/article/education/why-did-ncert-postpone-ntse-2022/
  2.​ Is the NTSE exam cancelled? Now there will no more NTSE examination happen.
       - Quora,
       https://www.quora.com/Is-the-NTSE-exam-cancelled-Now-there-will-no-more-NTS
       E-examination-happen
  3.​ NDA 2 2026 Notification PDF - SSBCrack,
       https://www.upsc.gov.in/sites/default/files/Notif-NDA-II-2026-Engl-200526.pdf
  4.​ PUBLIC NOTICE 24.12.2024 The National Testing Agency (NTA) will conduct the
       All- India Sainik School Entrance Examination (AISSE,
       http://www.nta.ac.in/Download/Notice/Notice_20241230125946.pdf
  5.​ schools - National Testing Agency,
       https://nta.ac.in/Download/Notice/Notice_20201106124100.pdf
  6.​ OJEE Lateral Entry 2026 - Dates, Registration, Eligibility, Syllabus, Admit Card,
       Cutoff, https://engineering.careers360.com/articles/ojee-lateral-entry
  7.​ Polytechnic Admission 2026: Entrance Exams, Application Form, Eligibility
       Criteria,
       https://www.collegedekho.com/articles/state-wise-polytechnic-entrance-exams/
  8.​ Polytechnic Entrance Exam 2026: Date, Exam Pattern, Eligibility Criteria, Career
       Option, How to Prepare? - Getmyuni,
       https://www.getmyuni.com/articles/polytechnic-entrance-exams
  9.​ NTSE Scholarship 2026 Notification: Check Eligibility, Stage 1 & 2 Exam Dates -
       Prepp, https://prepp.in/ntse-exam
  10.​https://www.education.gov.in/en/nmms
  11.​ Olympiads - HBCSE - TIFR, https://olympiads.hbcse.tifr.res.in/
12.​Polytechnic Admission 2026: Dates, Eligibility, Application Form, Counselling -
    Engineering,
    https://engineering.careers360.com/articles/polytechnic-admission-2026
13.​Login | Apprenticeship Training Portal,
    https://www.apprenticeshipindia.gov.in/">=;https:=/login/login/forgot-password/logi
    n/login/forgot-password/login/forgot-password/login/forgot-password/login/login/log
    in/login/forgot-password/login/login/login/login/forgot-password/login/forgot-passw
    ord/resend-activation-link/login/login/forgot-password/login/login/login/login/forgot-
    password/login/forgot-password/resend-activation-link/resend-activation-link/login/
    forgot-password/login/login/login/forgot-password/resend-activation-link/login/login
    /login/login/forgot-password/login/login/login/forgot-password/resend-activation-lin
    k/resend-activation-link
14.​Apprenticeship Opportunity View | Apprenticeship Training Portal,
    https://www.apprenticeshipindia.gov.in/apprenticeship/opportunity-view/6412cbf59
    77ed17c321d25e2
15.​शिक्षु प्रशिक्षण मंडल (पश्‍चिमी क्षेत्र), मंब
                                                ु ई - Board of Apprenticeship Training (Western
    Region), Mumbai - Ministry of Education, https://boatwr.education.gov.in/en/home/
16.​Tender Document - National Testing Agency,
    https://nta.ac.in/Download/Tender/Tender_20250220195355.pdf
17.​National Testing Agency, https://www.nta.ac.in/
18.​Information Bulletin December 2024 - UGC NET,
    https://ugcnet.nta.ac.in/images/information-bulletin-for-ugc-net-december-hrvplurn
    zjd47qa6oja9ksy6m5x6aq19112024.pdf
19.​UGC – NET JUNE 2025,
    https://ugcnet.nta.ac.in/images/information-bulletin-for-ugc-net-june-2025-1604202
    5.pdf
20.​NET December 2025 examination - National Testing Agency,
    http://www.nta.ac.in/Download/Notice/Notice_20251007175428.pdf
21.​CSIR-UGC NET - National Testing Agency, https://csirnet.nta.ac.in/
22.​PUBLIC NOTICE - National Testing Agency,
    https://www.nta.ac.in/Download/Notice/Notice_20200716081822.pdf
23.​Notification - STATE BANK OF INDIA,
    https://sbi.bank.in/documents/77530/36548767/060923-1_detailed+Advt.+English
    +PO+23-24_07.09.2023.pdf/9c9b6e4b-9fdd-df11-3194-d40cdb336aac?t=1694002
    437061
24.​PO/ 2021-22/18 - STATE BANK OF INDIA,
    https://sbi.bank.in/documents/77530/11154687/041021-Final+Advertisement+PO+
    21-22.pdf/61eb5452-c5e8-e057-e460-1e89486812d8?t=1633349820829
25.​Notif-CDS-II-2026-Engl-200526.pdf - UPSC,
    https://www.upsc.gov.in/sites/default/files/Notif-CDS-II-2026-Engl-200526.pdf
26.​NDA 2 2026 Notification PDF - SSBCrack,
    https://www.ssbcrack.com/wp-content/uploads/2026/05/NDA-2-2026-Notification.p
    df
27.​Important recommendations to transform Industrial Training Institutes (ITIs) – NITI
    Aayog Report - National Skills Network,
    https://nationalskillsnetwork.in/important-recommendations-to-transform-industrial-
    training-institutes-itis-niti-aayog-report/
28.​Skills for the Future: Transforming India's Workforce Landscape - Institute for
    Competitiveness,
    https://competitiveness.in/wp-content/uploads/2025/06/Report_Skill_Roadmap_Fi
    nal_Compressed.pdf
29.​Karnataka Secondary Education Examination Board - Wikipedia,
    https://en.wikipedia.org/wiki/Karnataka_Secondary_Education_Examination_Boar
    d
30.​Karnataka 2nd PUC Exam 1 Time Table 2027 PDF - Shiksha.com,
    https://www.shiksha.com/boards/karnataka-2nd-puc-board-timetable
31.​Andhra Pradesh Board (BSEAP) Helpline & Customer Care - DownRightNow,
    https://downrightnow.in/helpline/ap-board
32.​Board of Secondary Education Of Andhra Pradesh (BSEAP) - BYJU'S,
    https://byjus.com/ap-board/
33.​Edutips Result - Official Board & Exam Result, https://result.edutips.in/
34.​Subjects - West Bengal Council of Higher Secondary Education,
    https://wbchse.wb.gov.in/subjects/
35.​Bihar Board of Open Schooling and Examination (BBOSE),
    https://www.bbose.org/
36.​CBSE Board Exams to be Conducted Twice A Year - PW Store,
    https://store.pw.live/blogs/school-exams/cbse-board-exams-to-be-conducted-twice
    -a-year
37.​Board exams to be held twice a year? Education ministry asks CBSE to work out
    logistics,
    https://www.hindustantimes.com/education/news/education-ministry-asks-cbse-to-
    work-out-logistics-to-conduct-board-exams-twice-a-year-from-2025-10171413661
    0690.html
38.​CBSE Likely To Conduct 10 Class Board Exam Twice A Year Starting 2026 -
    Goodreturns,
    https://www.goodreturns.in/news/cbse-likely-to-conduct-10-class-board-exam-twic
    e-a-year-starting-2026-1408589.html
39.​CBSE Class 10 Board Exams to Be Held Twice a Year from Academic Year
    2025–26,
    https://targetpublications.org/blog/cbse-class-10-board-exams-to-be-held-twice-a-
    year-from-academic-year-202526
40.​(Admission and Allied Matters) Regulations, 2024 - West Bengal Council of Higher
    Secondary Education,
    https://wbchse.wb.gov.in/wp-content/uploads/2025/04/WBCHSE_Admission_REG
    ULATION_2024.pdf
41.​West Bengal Council of Higher Secondary Education Vidyasagar Bhavan,
    https://wbchse.wb.gov.in/?jet_download=37697
42.​NSQF Notification - National Council for Vocational Education and Training -
    ncvet, https://ncvet.gov.in/national-skills-qualification-framework/nsqf-notification/
43.​General Body Meeting - ncvet,
    https://ncvet.gov.in/wp-content/uploads/2026/04/Final-Agenda-for-the-1st-GB-mee
    ting.pdf
44.​SOP For Operationalization of National Credit Framework (NCrF) in Vocational
    Education, Training and Skilling (VETS) - ncvet,
    https://ncvet.gov.in/wp-content/uploads/2024/01/Draft-SOP_for_operationalization-
    of_NCrF-in-VETS-public-comments.pdf
45.​CTS ADMISSION NOTICE 2025-26 - National Skill Training Institute,
    https://nstibhubaneswar.dgt.gov.in/sites/default/files/2025-06/CTS%20Admission%
    20Notice%202025-26%20Website.pdf
46.​Annexure-II,
    https://dgt.gov.in/sites/default/files/2023-12/Annx-II_Draft_Career_Progression_Te
    mplate_for_States_UT.pdf
47.​Affiliation Orders 25.08.2015,
    https://dgt.gov.in/sites/default/files/2023-12/25082015affiliationorderpartII.pdf
48.​DGT-12/1/2016-TC - Government of India,
    https://dgt.gov.in/sites/default/files/2023-12/affiliationorder-07.10.2016-part-ii_com
    pressed.pdf
49.​Release of Affiliation Norms for Industrial Training Institutes (ITIs) 2025,
    https://www.dgt.gov.in/sites/default/files/2025-12/Circular-for-Affiliation-Norms-for-I
    TIs-2025.pdf
50.​DGT-12/1/2016-TC Government of India - प्रशिक्षण महानिदे शालय,
    https://dgt.gov.in/sites/default/files/2023-12/AffiliationOrders16092016II.pdf
51.​PM YASASVI Merit List 2023, Release Date, Download link - Physics Wallah,
    https://www.pw.live/state-prep/exams/pm-yasasvi-merit-list-2023
52.​PM Yasasvi Scholarship Scheme 2025, Eligibility, Application Process,
    https://vajiramandravi.com/current-affairs/pm-yasasvi-scholarship-scheme/
53.​PM Yasasvi Scholarship 2024: Learn about Scholarship, Application Online,
    Amount, Eligibility and Benefits - CollegeSearch,
    https://www.collegesearch.in/articles/pm-yasasvi-scholarship-2024
54.​PM YASASVI Yojana Application Form 2024: Online Registration, Dates, Eligibility,
    Exam Pattern, and Benefits - Collegedunia,
    https://collegedunia.com/exams/yasasvi/application-process
55.​UGC NET - National Testing Agency, https://ugcnet.nta.ac.in/
56.​26122024_Detailed_Adv.2024_27.12.2024.pdf - SBI Bank,
    https://sbi.co.in/documents/77530/43947057/26122024_Detailed_Adv.2024_27.12
    .2024.pdf/df8c5465-5f2d-67ca-6836-91923929f03f?t=1735214235754
