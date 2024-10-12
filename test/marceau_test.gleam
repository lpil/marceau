import gleam/io
import gleam/list
import gleeunit
import marceau

const extensions = [
  "123", "3dml", "3ds", "3g2", "3gp", "7z", "aab", "aac", "aam", "aas", "abw",
  "ac", "acc", "ace", "acu", "acutc", "adp", "aep", "afm", "afp", "ahead", "ai",
  "aif", "aifc", "aiff", "air", "ait", "ami", "apk", "appcache", "application",
  "apr", "arc", "asc", "asf", "asm", "aso", "asx", "atc", "atom", "atomcat",
  "atomsvc", "atx", "au", "avi", "aw", "azf", "azs", "azw", "bat", "bcpio",
  "bdf", "bdm", "bed", "bh2", "bin", "blb", "blorb", "bmi", "bmp", "book", "box",
  "boz", "bpk", "btif", "bz", "bz2", "c", "c11amc", "c11amz", "c4d", "c4f",
  "c4g", "c4p", "c4u", "cab", "caf", "cap", "car", "cat", "cb7", "cba", "cbr",
  "cbt", "cbz", "cc", "cct", "ccxml", "cdbcmsg", "cdf", "cdkey", "cdmia",
  "cdmic", "cdmid", "cdmio", "cdmiq", "cdx", "cdxml", "cdy", "cer", "cfs", "cgm",
  "chat", "chm", "chrt", "cif", "cii", "cil", "cla", "class", "clkk", "clkp",
  "clkt", "clkw", "clkx", "clp", "cmc", "cmdf", "cml", "cmp", "cmx", "cod",
  "com", "conf", "cpio", "cpp", "cpt", "crd", "crl", "crt", "cryptonote", "csh",
  "csml", "csp", "css", "cst", "csv", "cu", "curl", "cww", "cxt", "cxx", "dae",
  "daf", "dart", "dataless", "davmount", "dbk", "dcr", "dcurl", "dd2", "ddd",
  "deb", "def", "deploy", "der", "dfac", "dgc", "dic", "dir", "dis", "dist",
  "distz", "djv", "djvu", "dll", "dmg", "dmp", "dms", "dna", "doc", "docm",
  "docx", "dot", "dotm", "dotx", "dp", "dpg", "dra", "dsc", "dssc", "dtb", "dtd",
  "dts", "dtshd", "dump", "dvb", "dvi", "dwf", "dwg", "dxf", "dxp", "dxr",
  "ecelp4800", "ecelp7470", "ecelp9600", "ecma", "edm", "edx", "efif", "ei6",
  "elc", "emf", "eml", "emma", "emz", "eol", "eot", "eps", "epub", "es3", "esa",
  "esf", "et3", "etx", "eva", "evy", "exe", "exi", "ext", "ez", "ez2", "ez3",
  "f", "f4v", "f77", "f90", "fbs", "fcdt", "fcs", "fdf", "fe_launch", "fg5",
  "fgd", "fh", "fh4", "fh5", "fh7", "fhc", "fig", "flac", "fli", "flo", "flv",
  "flw", "flx", "fly", "fm", "fnc", "for", "fpx", "frame", "fsc", "fst", "ftc",
  "fti", "fvt", "fxp", "fxpl", "fzs", "g2w", "g3", "g3w", "gac", "gam", "gbr",
  "gca", "gdl", "geo", "gex", "ggb", "ggt", "ghf", "gif", "gim", "gml", "gmx",
  "gnumeric", "gph", "gpx", "gqf", "gqs", "gram", "gramps", "gre", "grv",
  "grxml", "gsf", "gtar", "gtm", "gtw", "gv", "gxf", "gxt", "h", "h261", "h263",
  "h264", "hal", "hbci", "hdf", "hh", "hlp", "hpgl", "hpid", "hps", "hqx",
  "htke", "htm", "html", "hvd", "hvp", "hvs", "i2g", "icc", "ice", "icm", "ico",
  "ics", "ief", "ifb", "ifm", "iges", "igl", "igm", "igs", "igx", "iif", "imp",
  "ims", "in", "ink", "inkml", "install", "iota", "ipfix", "ipk", "irm", "irp",
  "iso", "itp", "ivp", "ivu", "jad", "jam", "jar", "java", "jisp", "jlt", "jnlp",
  "joda", "jpe", "jpeg", "jpg", "jpgm", "jpgv", "jpm", "js", "json", "jsonml",
  "kar", "karbon", "kfo", "kia", "kml", "kmz", "kne", "knp", "kon", "kpr", "kpt",
  "kpxx", "ksp", "ktr", "ktx", "ktz", "kwd", "kwt", "lasxml", "latex", "lbd",
  "lbe", "les", "lha", "link66", "list", "list3820", "listafp", "lnk", "log",
  "lostxml", "lrf", "lrm", "ltf", "lvp", "lwp", "lzh", "m13", "m14", "m1v",
  "m21", "m2a", "m2v", "m3a", "m3u", "m3u8", "m4a", "m4u", "m4v", "ma", "mads",
  "mag", "maker", "man", "mar", "mathml", "mb", "mbk", "mbox", "mc1", "mcd",
  "mcurl", "mdb", "mdi", "me", "mesh", "meta4", "metalink", "mets", "mfm", "mft",
  "mgp", "mgz", "mid", "midi", "mie", "mif", "mime", "mj2", "mjp2", "mk3d",
  "mka", "mks", "mkv", "mlp", "mmd", "mmf", "mmr", "mng", "mny", "mobi", "mods",
  "mov", "movie", "mp2", "mp21", "mp2a", "mp3", "mp4", "mp4a", "mp4s", "mp4v",
  "mpc", "mpe", "mpeg", "mpg", "mpg4", "mpga", "mpkg", "mpm", "mpn", "mpp",
  "mpt", "mpy", "mqy", "mrc", "mrcx", "ms", "mscml", "mseed", "mseq", "msf",
  "msh", "msi", "msl", "msty", "mts", "mus", "musicxml", "mvb", "mwf", "mxf",
  "mxl", "mxml", "mxs", "mxu", "n-gage", "n3", "nb", "nbp", "nc", "ncx", "nfo",
  "ngdat", "nitf", "nlu", "nml", "nnd", "nns", "nnw", "npx", "nsc", "nsf", "ntf",
  "nzb", "oa2", "oa3", "oas", "obd", "obj", "oda", "odb", "odc", "odf", "odft",
  "odg", "odi", "odm", "odp", "ods", "odt", "oga", "ogg", "ogv", "ogx", "omdoc",
  "onepkg", "onetmp", "onetoc", "onetoc2", "opf", "opml", "oprc", "org", "osf",
  "osfpvg", "otc", "otf", "otg", "oth", "oti", "otp", "ots", "ott", "oxps",
  "oxt", "p", "p10", "p12", "p7b", "p7c", "p7m", "p7r", "p7s", "p8", "pas",
  "paw", "pbd", "pbm", "pcap", "pcf", "pcl", "pclxl", "pct", "pcurl", "pcx",
  "pdb", "pdf", "pfa", "pfb", "pfm", "pfr", "pfx", "pgm", "pgn", "pgp", "pic",
  "pkg", "pki", "pkipath", "plb", "plc", "plf", "pls", "pml", "png", "pnm",
  "portpkg", "pot", "potm", "potx", "ppam", "ppd", "ppm", "pps", "ppsm", "ppsx",
  "ppt", "pptm", "pptx", "pqa", "prc", "pre", "prf", "ps", "psb", "psd", "psf",
  "pskcxml", "ptid", "pub", "pvb", "pwn", "pya", "pyv", "qam", "qbo", "qfx",
  "qps", "qt", "qwd", "qwt", "qxb", "qxd", "qxl", "qxt", "ra", "ram", "rar",
  "ras", "rcprofile", "rdf", "rdz", "rep", "res", "rgb", "rif", "rip", "ris",
  "rl", "rlc", "rld", "rm", "rmi", "rmp", "rms", "rmvb", "rnc", "roa", "roff",
  "rp9", "rpss", "rpst", "rq", "rs", "rsd", "rss", "rtf", "rtx", "s", "s3m",
  "saf", "sbml", "sc", "scd", "scm", "scq", "scs", "scurl", "sda", "sdc", "sdd",
  "sdkd", "sdkm", "sdp", "sdw", "see", "seed", "sema", "semd", "semf", "ser",
  "setpay", "setreg", "sfd-hdstx", "sfs", "sfv", "sgi", "sgl", "sgm", "sgml",
  "sh", "shar", "shf", "sid", "sig", "sil", "silo", "sis", "sisx", "sit", "sitx",
  "skd", "skm", "skp", "skt", "sldm", "sldx", "slt", "sm", "smf", "smi", "smil",
  "smv", "smzip", "snd", "snf", "so", "spc", "spf", "spl", "spot", "spp", "spq",
  "spx", "sql", "src", "srt", "sru", "srx", "ssdl", "sse", "ssf", "ssml", "st",
  "stc", "std", "stf", "sti", "stk", "stl", "str", "stw", "sub", "sus", "susp",
  "sv4cpio", "sv4crc", "svc", "svd", "svg", "svgz", "swa", "swf", "swi", "sxc",
  "sxd", "sxg", "sxi", "sxm", "sxw", "t", "t3", "taglet", "tao", "tar", "tcap",
  "tcl", "teacher", "tei", "teicorpus", "tex", "texi", "texinfo", "text", "tfi",
  "tfm", "tga", "thmx", "tif", "tiff", "tmo", "torrent", "tpl", "tpt", "tr",
  "tra", "trm", "tsd", "tsv", "ttc", "ttf", "ttl", "twd", "twds", "txd", "txf",
  "txt", "u32", "udeb", "ufd", "ufdl", "ulx", "umj", "unityweb", "uoml", "uri",
  "uris", "urls", "ustar", "utz", "uu", "uva", "uvd", "uvf", "uvg", "uvh", "uvi",
  "uvm", "uvp", "uvs", "uvt", "uvu", "uvv", "uvva", "uvvd", "uvvf", "uvvg",
  "uvvh", "uvvi", "uvvm", "uvvp", "uvvs", "uvvt", "uvvu", "uvvv", "uvvx", "uvvz",
  "uvx", "uvz", "vcard", "vcd", "vcf", "vcg", "vcs", "vcx", "vis", "viv", "vob",
  "vor", "vox", "vrml", "vsd", "vsf", "vss", "vst", "vsw", "vtu", "vxml", "w3d",
  "wad", "wav", "wax", "wbmp", "wbs", "wbxml", "wcm", "wdb", "wdp", "weba",
  "webm", "webp", "wg", "wgt", "wks", "wm", "wma", "wmd", "wmf", "wml", "wmlc",
  "wmls", "wmlsc", "wmv", "wmx", "wmz", "woff", "woff2", "wpd", "wpl", "wps",
  "wqd", "wri", "wrl", "wsdl", "wspolicy", "wtb", "wvx", "x32", "x3d", "x3db",
  "x3dbz", "x3dv", "x3dvz", "x3dz", "xaml", "xap", "xar", "xbap", "xbd", "xbm",
  "xdf", "xdm", "xdp", "xdssc", "xdw", "xenc", "xer", "xfdf", "xfdl", "xht",
  "xhtml", "xhvml", "xif", "xla", "xlam", "xlc", "xlf", "xlm", "xls", "xlsb",
  "xlsm", "xlsx", "xlt", "xltm", "xltx", "xlw", "xm", "xml", "xo", "xop", "xpi",
  "xpl", "xpm", "xpr", "xps", "xpw", "xpx", "xsl", "xslt", "xsm", "xspf", "xul",
  "xvm", "xvml", "xwd", "xyz", "xz", "yang", "yin", "z1", "z2", "z3", "z4", "z5",
  "z6", "z7", "z8", "zaz", "zip", "zir", "zirz", "zmm",
]

pub fn main() {
  gleeunit.main()
}

pub fn roundtrip_test() {
  use extension <- list.each(extensions)

  let mime = marceau.extension_to_mime_type(extension)
  let extensions = marceau.mime_type_to_extensions(mime)

  io.println(extension)
  let assert True = list.contains(extensions, extension)
}

pub fn unknown_extension_test() {
  let assert "application/octet-stream" =
    marceau.extension_to_mime_type("unknown")
}

pub fn unknown_mime_type_test() {
  let assert [] = marceau.mime_type_to_extensions("unknown")
}

pub fn javascript_test() {
  let assert "text/javascript" = marceau.extension_to_mime_type("js")
  let assert "text/javascript" = marceau.extension_to_mime_type("mjs")
  let assert ["js", "mjs"] = marceau.mime_type_to_extensions("text/javascript")
  let assert ["js", "mjs"] =
    marceau.mime_type_to_extensions("application/javascript")
}
