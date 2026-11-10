########################################################
## 00_config.R — Central configuration
##
## Every script starts with source("00_config.R").
## All paths are relative to the root folder of the repository,
## so the scripts must be run from that folder.
########################################################

options(encoding = "UTF-8")
invisible(suppressWarnings(Sys.setlocale("LC_ALL", "UTF-8")))

# -----------------------------------------------------------------------
# 1. Root directory
# -----------------------------------------------------------------------
if (!file.exists("00_config.R")) {
  stop("Run the scripts from the root folder of the repository ",
       "(the folder that contains 00_config.R).")
}
ROOT_DIR <- normalizePath(getwd(), winslash = "/")

# -----------------------------------------------------------------------
# 2. Input paths
#    Files marked (not distributed) must be obtained from the source and
#    placed in the folder indicated. See the README for details.
# -----------------------------------------------------------------------
INPUT_DIR <- file.path(ROOT_DIR, "input")

# DANE retail prices, up to March 2018 (not distributed)
IN_PRICES <- file.path(INPUT_DIR, "dane-retail-prices",
                       "precios_unadj_DANE_1999_2018.xlsx")

# DANE consumer price index series and correspondence tables
IN_IPC    <- file.path(INPUT_DIR, "cpi", "IPC.xls")
IN_IPC2   <- file.path(INPUT_DIR, "cpi", "IPC_2.xls")
IN_IPC3   <- file.path(INPUT_DIR, "cpi", "IPC_3.xls")
IN_IPC4   <- file.path(INPUT_DIR, "cpi", "IPC_4.xls")
IN_CORR1  <- file.path(INPUT_DIR, "cpi", "correlativa_ipc.xlsx")
IN_CORR2  <- file.path(INPUT_DIR, "cpi", "correlativa_ipc_articulos.xlsx")

# Colombian Food Composition Table (TCAC)
IN_TCAC     <- file.path(INPUT_DIR, "tcac", "Copia_DANE_4_DIC_2025act.xlsx")

# Energy requirements (EER)
IN_EER      <- file.path(INPUT_DIR, "eer", "220326_agg_eer.xlsx")

# GEIH microdata (Great Integrated Household Survey, DANE; not distributed)
GEIH_PERSONAS_DIR <- file.path(INPUT_DIR, "geih", "personas")
GEIH_HOGARES_DIR  <- file.path(INPUT_DIR, "geih", "hogares")

# GEIH years to process
GEIH_YEARS <- 2019:2024

# -----------------------------------------------------------------------
# 3. Output subdirectories
# -----------------------------------------------------------------------

# 00_pipeline — price panel
PIPE_DIR    <- file.path(ROOT_DIR, "00_pipeline")
CACHE_DIR   <- file.path(PIPE_DIR,   "cache")
FORECAST_DIR<- file.path(PIPE_DIR,   "price_forecasting")
ROBUST_DIR  <- file.path(PIPE_DIR,   "robust")

# 01_data_preparation
PREP_DIR    <- file.path(ROOT_DIR, "01_data_preparation")

# 03_income
INCOME_DIR  <- file.path(ROOT_DIR, "03_income")

dirs_to_create <- c(CACHE_DIR, FORECAST_DIR, ROBUST_DIR, PREP_DIR, INCOME_DIR)
invisible(lapply(dirs_to_create, dir.create,
                 recursive = TRUE, showWarnings = FALSE))

# -----------------------------------------------------------------------
# 4. Shared parameters
# -----------------------------------------------------------------------
TRAIN_END    <- as.Date("2015-12-01")
T0           <- as.Date("2016-01-01")   # anchor date
VAL_START    <- as.Date("2016-02-01")   # validation start (IPC ratio ≠ 1)
VAL_END      <- as.Date("2018-03-01")   # validation end
PAPER_START  <- as.Date("2019-01-01")   # paper period start
PAPER_END    <- as.Date("2024-12-01")   # paper period end
EXTRAP_START <- as.Date("2018-04-01")   # extrapolation start

CITIES_USE   <- c("CALI", "BOGOTÁ D.C.", "MEDELLÍN")
MIN_OBS      <- 24L

# Validity bounds (from the grid search in 03_threshold_opt.R)
R2_MIN  <- 0.10
LAM_MIN <- 0.20
LAM_MAX <- 4.00

# Colours (shared across all figures)
COL_BOGOTA   <- "#2E5FA3"
COL_CALI     <- "#1A7A4A"
COL_MEDELLIN <- "#C0392B"

CITY_LABELS <- c(
  "BOGOTÁ D.C." = "Bogotá",
  "CALI"        = "Cali",
  "MEDELLÍN"    = "Medellín",
  "BOGOTA"      = "Bogotá",
  "MEDELLIN"    = "Medellín"
)

CITY_COLORS <- c(
  "Bogotá"   = COL_BOGOTA,
  "Cali"     = COL_CALI,
  "Medellín" = COL_MEDELLIN
)

message("Config loaded. Root dir: ", ROOT_DIR)
