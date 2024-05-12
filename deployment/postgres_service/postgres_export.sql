--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sst_era5; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sst_era5 (
    id integer NOT NULL,
    "time" timestamp without time zone,
    avg_sst double precision,
    latitude double precision,
    longitude double precision,
    "95_lower_bound_CI" double precision,
    "95_upper_bound_CI" double precision,
    "99_lower_bound_CI" double precision,
    "99_upper_bound_CI" double precision
);


ALTER TABLE public.sst_era5 OWNER TO postgres;

--
-- Name: sst_era5_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sst_era5_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sst_era5_id_seq OWNER TO postgres;

--
-- Name: sst_era5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sst_era5_id_seq OWNED BY public.sst_era5.id;


--
-- Name: sst_era5 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sst_era5 ALTER COLUMN id SET DEFAULT nextval('public.sst_era5_id_seq'::regclass);


--
-- Data for Name: sst_era5; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sst_era5 (id, "time", avg_sst, latitude, longitude, "95_lower_bound_CI", "95_upper_bound_CI", "99_lower_bound_CI", "99_upper_bound_CI") FROM stdin;
1	2013-01-01 00:00:00	302.96240911515923	-2.75	165.25	302.87427975747	303.0505384728485	302.8465875062779	303.07823072404057
2	2013-02-01 00:00:00	302.7392845603309	-2.75	165.25	302.65115520264163	302.8274139180201	302.62346295144954	302.8551061692122
3	2013-03-01 00:00:00	302.4772575641761	-2.75	165.25	302.3891282064869	302.56538692186535	302.3614359552948	302.59307917305745
4	2013-04-01 00:00:00	302.61163093886233	-2.75	165.25	302.5235015811731	302.6997602965516	302.495809329981	302.72745254774367
5	2013-05-01 00:00:00	302.8107935573439	-2.75	165.25	302.7226641996547	302.89892291503315	302.6949719484626	302.92661516622525
6	2013-06-01 00:00:00	302.9601059665237	-2.75	165.25	302.8719766088345	303.04823532421295	302.8442843576424	303.07592757540505
7	2013-07-01 00:00:00	303.0137084883751	-2.75	165.25	302.92557913068583	303.1018378460643	302.89788687949374	303.1295300972564
8	2013-08-01 00:00:00	302.9669345357025	-2.75	165.25	302.87880517801324	303.0550638933917	302.85111292682114	303.0827561445838
9	2013-09-01 00:00:00	303.0408168970557	-2.75	165.25	302.9526875393665	303.12894625474496	302.9249952881744	303.15663850593705
10	2013-10-01 00:00:00	303.55754897214666	-2.75	165.25	303.4694196144574	303.6456783298359	303.44172736326533	303.673370581028
11	2013-11-01 00:00:00	303.60163156789014	-2.75	165.25	303.5135022102009	303.6897609255794	303.4858099590088	303.71745317677147
12	2013-12-01 00:00:00	303.3682114056097	-2.75	165.25	303.2800820479205	303.45634076329895	303.2523897967284	303.48403301449105
13	2014-01-01 00:00:00	302.9642659713058	-2.75	165.25	302.87613661361655	303.05239532899503	302.84844436242446	303.0800875801871
14	2014-02-01 00:00:00	303.0849527979152	-2.75	165.25	302.99682344022597	303.17308215560445	302.9691311890339	303.20077440679654
15	2014-03-01 00:00:00	302.9797659961933	-2.75	165.25	302.89163663850405	303.06789535388253	302.86394438731196	303.0955876050746
16	2014-04-01 00:00:00	302.9130823988594	-2.75	165.25	302.82495304117015	303.0012117565486	302.79726078997805	303.0289040077407
17	2014-05-01 00:00:00	303.4088574756637	-2.75	165.25	303.32072811797445	303.49698683335293	303.29303586678236	303.524679084545
18	2014-06-01 00:00:00	303.5131877193137	-2.75	165.25	303.42505836162445	303.60131707700293	303.39736611043236	303.629009328195
19	2014-07-01 00:00:00	303.2733150646389	-2.75	165.25	303.18518570694965	303.36144442232813	303.15749345575756	303.3891366735202
20	2014-08-01 00:00:00	303.29597415042474	-2.75	165.25	303.2078447927355	303.384103508114	303.1801525415434	303.4117957593061
21	2014-09-01 00:00:00	303.6253424187592	-2.75	165.25	303.53721306106996	303.71347177644844	303.50952080987787	303.74116402764054
22	2014-10-01 00:00:00	303.7688589075259	-2.75	165.25	303.68072954983666	303.85698826521514	303.65303729864456	303.88468051640723
23	2014-11-01 00:00:00	303.9661220257681	-2.75	165.25	303.87799266807883	304.0542513834573	303.85030041688674	304.0819436346494
24	2014-12-01 00:00:00	303.85282475873134	-2.75	165.25	303.7646954010421	303.9409541164206	303.73700314985	303.9686463676127
25	2015-01-01 00:00:00	303.5765483859985	-2.75	165.25	303.48841902830924	303.6646777436877	303.46072677711715	303.6923699948798
26	2015-02-01 00:00:00	303.3002462797613	-2.75	165.25	303.2121169220721	303.38837563745057	303.18442467088	303.41606788864266
27	2015-03-01 00:00:00	303.05099890946724	-2.75	165.25	302.962869551778	303.1391282671565	302.9351773005859	303.1668205183486
28	2015-04-01 00:00:00	303.3343803027395	-2.75	165.25	303.24625094505024	303.4225096604287	303.21855869385814	303.4502019116208
29	2015-05-01 00:00:00	303.2230156218762	-2.75	165.25	303.13488626418695	303.3111449795654	303.10719401299485	303.3388372307575
30	2015-06-01 00:00:00	303.2561379505136	-2.75	165.25	303.1680085928244	303.34426730820286	303.1403163416323	303.37195955939495
31	2015-07-01 00:00:00	303.07168901455213	-2.75	165.25	302.9835596568629	303.1598183722414	302.9558674056708	303.18751062343347
32	2015-08-01 00:00:00	302.49541990389497	-2.75	165.25	302.40729054620573	302.5835492615842	302.37959829501364	302.6112415127763
33	2015-09-01 00:00:00	302.5548845180276	-2.75	165.25	302.4667551603384	302.64301387571686	302.4390629091463	302.67070612690895
34	2015-10-01 00:00:00	302.87128567354137	-2.75	165.25	302.7831563158521	302.9594150312306	302.75546406466003	302.9871072824227
35	2015-11-01 00:00:00	303.2981806146084	-2.75	165.25	303.21005125691914	303.3863099722976	303.18235900572705	303.4140022234897
36	2015-12-01 00:00:00	302.9186908323125	-2.75	165.25	302.83056147462327	303.00682019000175	302.8028692234312	303.03451244119384
37	2016-01-01 00:00:00	302.7601779600997	-2.75	165.25	302.6720486024105	302.84830731778897	302.6443563512184	302.87599956898106
38	2016-02-01 00:00:00	302.6289374557522	-2.75	165.25	302.54080809806294	302.7170668134414	302.51311584687085	302.7447590646335
39	2016-03-01 00:00:00	303.1300239278456	-2.75	165.25	303.0418945701564	303.21815328553487	303.0142023189643	303.24584553672696
40	2016-04-01 00:00:00	303.05981888425794	-2.75	165.25	302.9716895265687	303.1479482419472	302.9439972753766	303.17564049313927
41	2016-05-01 00:00:00	303.3088353882562	-2.75	165.25	303.220706030567	303.39696474594547	303.1930137793749	303.42465699713756
42	2016-06-01 00:00:00	303.57790307118955	-2.75	165.25	303.4897737135003	303.6660324288788	303.4620814623082	303.6937246800709
43	2016-07-01 00:00:00	303.44341573384133	-2.75	165.25	303.3552863761521	303.5315450915306	303.32759412496	303.55923734272267
44	2016-08-01 00:00:00	303.3345041911816	-2.75	165.25	303.2463748334924	303.42263354887086	303.2186825823003	303.45032580006296
45	2016-09-01 00:00:00	303.21135724156034	-2.75	165.25	303.1232278838711	303.2994865992496	303.095535632679	303.32717885044167
46	2016-10-01 00:00:00	303.0954428771355	-2.75	165.25	303.00731351944626	303.18357223482474	302.97962126825416	303.21126448601683
47	2016-11-01 00:00:00	302.8624723159375	-2.75	165.25	302.77434295824827	302.95060167362675	302.7466507070562	302.97829392481884
48	2016-12-01 00:00:00	303.2546777579548	-2.75	165.25	303.1665484002656	303.34280711564406	303.1388561490735	303.37049936683616
49	2017-01-01 00:00:00	303.2848594822928	-2.75	165.25	303.19673012460356	303.37298883998204	303.16903787341147	303.40068109117414
50	2017-02-01 00:00:00	303.0709523010859	-2.75	165.25	302.9828229433967	303.15908165877516	302.9551306922046	303.18677390996726
51	2017-03-01 00:00:00	302.3269279463332	-2.75	165.25	302.238798588644	302.41505730402247	302.2111063374519	302.44274955521456
52	2017-04-01 00:00:00	302.6468020220641	-2.75	165.25	302.55867266437485	302.73493137975333	302.53098041318276	302.7626236309454
53	2017-05-01 00:00:00	302.8350587814201	-2.75	165.25	302.7469294237309	302.92318813910936	302.7192371725388	302.95088039030145
54	2017-06-01 00:00:00	303.201593950026	-2.75	165.25	303.11346459233675	303.28972330771524	303.08577234114466	303.3174155589073
55	2017-07-01 00:00:00	303.0740421597103	-2.75	165.25	302.98591280202106	303.16217151739954	302.95822055082897	303.18986376859164
56	2017-08-01 00:00:00	303.0726301255668	-2.75	165.25	302.98450076787753	303.160759483256	302.95680851668544	303.1884517344481
57	2017-09-01 00:00:00	302.9204285790962	-2.75	165.25	302.83229922140697	303.00855793678545	302.8046069702149	303.03625018797754
58	2017-10-01 00:00:00	302.6775951009401	-2.75	165.25	302.58946574325086	302.76572445862934	302.56177349205876	302.79341670982143
59	2017-11-01 00:00:00	303.02485109574025	-2.75	165.25	302.936721738051	303.1129804534295	302.9090294868589	303.1406727046216
60	2017-12-01 00:00:00	303.02867288875143	-2.75	165.25	302.9405435310622	303.11680224644067	302.9128512798701	303.14449449763276
61	2018-01-01 00:00:00	303.0522326471881	-2.75	165.25	302.96410328949884	303.1403620048773	302.93641103830674	303.1680542560694
62	2018-02-01 00:00:00	302.6923767934359	-2.75	165.25	302.6042474357467	302.78050615112517	302.5765551845546	302.80819840231726
63	2018-03-01 00:00:00	302.8521068604024	-2.75	165.25	302.76397750271315	302.9402362180916	302.73628525152105	302.9679284692837
64	2018-04-01 00:00:00	303.04907955766737	-2.75	165.25	302.96095019997813	303.1372089153566	302.93325794878604	303.1649011665487
65	2018-05-01 00:00:00	303.2628521894089	-2.75	165.25	303.17472283171963	303.3509815470981	303.14703058052754	303.3786737982902
66	2018-06-01 00:00:00	303.1696825665771	-2.75	165.25	303.08155320888784	303.2578119242663	303.05386095769575	303.2855041754584
67	2018-07-01 00:00:00	303.0889992076569	-2.75	165.25	303.00086984996767	303.17712856534615	302.9731775987756	303.20482081653824
68	2018-08-01 00:00:00	303.27705377519334	-2.75	165.25	303.1889244175041	303.3651831328826	303.161232166312	303.39287538407467
69	2018-09-01 00:00:00	303.40569923944213	-2.75	165.25	303.3175698817529	303.49382859713137	303.2898776305608	303.52152084832346
70	2018-10-01 00:00:00	303.80602066109657	-2.75	165.25	303.7178913034073	303.8941500187858	303.69019905221523	303.9218422699779
71	2018-11-01 00:00:00	303.53109566496136	-2.75	165.25	303.4429663072721	303.6192250226506	303.41527405608	303.6469172738427
72	2018-12-01 00:00:00	303.5714855028367	-2.75	165.25	303.48335614514747	303.65961486052595	303.4556638939554	303.68730711171804
73	2019-01-01 00:00:00	303.2261595208596	-2.75	165.25	303.13803016317036	303.31428887854884	303.11033791197826	303.34198112974093
74	2019-02-01 00:00:00	302.7735185763543	-2.75	165.25	302.6853892186651	302.86164793404356	302.657696967473	302.88934018523565
75	2019-03-01 00:00:00	302.90482047349064	-2.75	165.25	302.8166911158014	302.9929498311799	302.7889988646093	303.020642082372
76	2019-04-01 00:00:00	302.84730609136307	-2.75	165.25	302.7591767336738	302.9354354490523	302.73148448248173	302.9631277002444
77	2019-05-01 00:00:00	303.02088262175454	-2.75	165.25	302.9327532640653	303.1090119794438	302.9050610128732	303.13670423063587
78	2019-06-01 00:00:00	303.076784983648	-2.75	165.25	302.98865562595876	303.16491434133724	302.96096337476666	303.19260659252933
79	2019-07-01 00:00:00	303.22092789943383	-2.75	165.25	303.1327985417446	303.3090572571231	303.1051062905525	303.33674950831517
80	2019-08-01 00:00:00	303.4299196136965	-2.75	165.25	303.34179025600724	303.5180489713857	303.31409800481515	303.5457412225778
81	2019-09-01 00:00:00	303.6480132684327	-2.75	165.25	303.55988391074345	303.73614262612193	303.53219165955136	303.763834877314
82	2019-10-01 00:00:00	303.92451058168115	-2.75	165.25	303.8363812239919	304.0126399393704	303.8086889727998	304.0403321905625
83	2019-11-01 00:00:00	303.7087961732289	-2.75	165.25	303.62066681553966	303.79692553091814	303.59297456434757	303.82461778211024
84	2019-12-01 00:00:00	303.4677441888138	-2.75	165.25	303.37961483112457	303.55587354650305	303.3519225799325	303.58356579769514
85	2020-01-01 00:00:00	303.1166550047363	-2.75	165.25	303.02852564704705	303.2047843624255	303.00083339585495	303.2324766136176
86	2020-02-01 00:00:00	302.99933081189687	-2.75	165.25	302.9112014542076	303.0874601695861	302.88350920301554	303.1151524207782
87	2020-03-01 00:00:00	303.1297257868171	-2.75	165.25	303.0415964291279	303.21785514450636	303.0139041779358	303.24554739569845
88	2020-04-01 00:00:00	302.98509136109897	-2.75	165.25	302.8969620034097	303.0732207187882	302.86926975221763	303.1009129699803
89	2020-05-01 00:00:00	302.918782002442	-2.75	165.25	302.8306526447528	303.00691136013126	302.8029603935607	303.03460361132335
90	2020-06-01 00:00:00	302.987191582672	-2.75	165.25	302.89906222498274	303.0753209403612	302.87136997379065	303.1030131915533
91	2020-07-01 00:00:00	302.86373472813455	-2.75	165.25	302.7756053704453	302.9518640858238	302.7479131192532	302.9795563370159
92	2020-08-01 00:00:00	302.66330308026915	-2.75	165.25	302.5751737225799	302.7514324379584	302.5474814713878	302.7791246891505
93	2020-09-01 00:00:00	302.45362391382	-2.75	165.25	302.3654945561308	302.54175327150926	302.3378023049387	302.56944552270136
94	2020-10-01 00:00:00	302.2837357298388	-2.75	165.25	302.19560637214954	302.371865087528	302.16791412095745	302.3995573387201
95	2020-11-01 00:00:00	302.26166924989496	-2.75	165.25	302.1735398922057	302.3497986075842	302.14584764101363	302.3774908587763
96	2020-12-01 00:00:00	302.4187149447407	-2.75	165.25	302.3305855870515	302.50684430242995	302.3028933358594	302.53453655362205
97	2021-01-01 00:00:00	301.8025761806168	-2.75	165.25	301.7144468229276	301.89070553830607	301.6867545717355	301.91839778949816
98	2021-02-01 00:00:00	302.1065381277698	-2.75	165.25	302.01840877008055	302.19466748545904	301.99071651888846	302.22235973665113
99	2021-03-01 00:00:00	302.0672268913464	-2.75	165.25	301.9790975336572	302.15535624903566	301.9514052824651	302.18304850022776
100	2021-04-01 00:00:00	302.52793675993814	-2.75	165.25	302.4398074022489	302.6160661176274	302.4121151510568	302.6437583688195
101	2021-05-01 00:00:00	302.9237945214596	-2.75	165.25	302.8356651637704	303.01192387914887	302.8079729125783	303.03961613034096
102	2021-06-01 00:00:00	302.95849651964	-2.75	165.25	302.87036716195075	303.04662587732923	302.84267491075866	303.0743181285213
103	2021-07-01 00:00:00	302.74319017104176	-2.75	165.25	302.6550608133525	302.831319528731	302.6273685621604	302.8590117799231
104	2021-08-01 00:00:00	302.8241790234203	-2.75	165.25	302.73604966573106	302.91230838110954	302.70835741453897	302.94000063230163
105	2021-09-01 00:00:00	302.3256611226783	-2.75	165.25	302.23753176498906	302.41379048036754	302.20983951379696	302.44148273155963
106	2021-10-01 00:00:00	302.30254581862323	-2.75	165.25	302.214416460934	302.39067517631247	302.1867242097419	302.41836742750456
107	2021-11-01 00:00:00	302.09360887996263	-2.75	165.25	302.0054795222734	302.18173823765187	301.9777872710813	302.20943048884396
108	2021-12-01 00:00:00	302.2731633034047	-2.75	165.25	302.1850339457155	302.36129266109396	302.1573416945234	302.38898491228605
109	2022-01-01 00:00:00	302.8820624975239	-2.75	165.25	302.7939331398347	302.97019185521316	302.7662408886426	302.99788410640525
110	2022-02-01 00:00:00	302.7155237129392	-2.75	165.25	302.62739435525	302.80365307062846	302.5997021040579	302.83134532182055
111	2022-03-01 00:00:00	302.0163918240726	-2.75	165.25	301.9282624663834	302.10452118176187	301.9005702151913	302.13221343295396
112	2022-04-01 00:00:00	301.8125379877557	-2.75	165.25	301.7244086300665	301.90066734544496	301.6967163788744	301.92835959663705
113	2022-05-01 00:00:00	302.1155823516694	-2.75	165.25	302.02745299398015	302.20371170935863	301.99976074278806	302.2314039605507
114	2022-06-01 00:00:00	302.1728085185488	-2.75	165.25	302.08467916085954	302.260937876238	302.05698690966744	302.2886301274301
115	2022-07-01 00:00:00	301.64377693126323	-2.75	165.25	301.555647573574	301.7319062889525	301.5279553223819	301.75959854014457
116	2022-08-01 00:00:00	301.63758103866894	-2.75	165.25	301.5494516809797	301.7257103963582	301.5217594297876	301.7534026475503
117	2022-09-01 00:00:00	301.53367172162507	-2.75	165.25	301.44554236393583	301.6218010793143	301.41785011274374	301.6494933305064
118	2022-10-01 00:00:00	301.62383603877527	-2.75	165.25	301.535706681086	301.7119653964645	301.50801442989393	301.7396576476566
119	2022-11-01 00:00:00	301.92217962669486	-2.75	165.25	301.8340502690056	302.0103089843841	301.8063580178135	302.0380012355762
120	2022-12-01 00:00:00	302.03272634974263	-2.75	165.25	301.9445969920534	302.1208557074319	301.9169047408613	302.14854795862396
121	2023-01-01 00:00:00	301.964712330236	-2.75	165.25	301.87658297254677	302.05284168792525	301.8488907213547	302.08053393911734
122	2023-02-01 00:00:00	301.96911974428093	-2.75	165.25	301.8809903865917	302.05724910197017	301.8532981353996	302.08494135316226
123	2023-03-01 00:00:00	302.27334564366384	-2.75	165.25	302.1852162859746	302.3614750013531	302.1575240347825	302.3891672525452
124	2023-04-01 00:00:00	302.7993395745766	-2.75	165.25	302.71121021688737	302.88746893226585	302.6835179656953	302.91516118345794
125	2023-05-01 00:00:00	303.1687429260484	-2.75	165.25	303.0806135683592	303.25687228373766	303.0529213171671	303.28456453492976
126	2023-06-01 00:00:00	303.326831930683	-2.75	165.25	303.23870257299376	303.41496128837224	303.21101032180167	303.44265353956433
127	2023-07-01 00:00:00	303.08652915886483	-2.75	165.25	302.9983998011756	303.1746585165541	302.9707075499835	303.20235076774617
128	2023-08-01 00:00:00	303.1272141967967	-2.75	165.25	303.03908483910743	303.2153435544859	303.01139258791534	303.243035805678
129	2023-09-01 00:00:00	303.391580368493	-2.75	165.25	303.30345101080377	303.47970972618225	303.2757587596117	303.50740197737434
130	2023-10-01 00:00:00	303.47260083631966	-2.75	165.25	303.3844714786304	303.5607301940089	303.3567792274383	303.588422445201
131	2023-11-01 00:00:00	303.31581027078806	-2.75	165.25	303.2276809130988	303.4039396284773	303.19998866190673	303.4316318796694
132	2023-12-01 00:00:00	303.2107425784289	-2.75	165.25	303.12261322073965	303.29887193611813	303.09492096954756	303.3265641873102
133	2024-01-01 00:00:00	303.56404263814795	-2.75	165.25	303.4759132804587	303.6521719958372	303.4482210292666	303.6798642470293
134	2024-02-01 00:00:00	303.3781662279404	-2.75	165.25	303.2900368702512	303.46629558562967	303.2623446190591	303.49398783682176
135	2024-03-01 00:00:00	303.3219719745838	-2.75	165.25	303.23384261689455	303.41010133227303	303.20615036570246	303.4377935834651
\.


--
-- Name: sst_era5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sst_era5_id_seq', 1, false);


--
-- Name: sst_era5 sst_era5_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sst_era5
    ADD CONSTRAINT sst_era5_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--
