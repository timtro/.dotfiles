#!/usr/bin/awk -f
#
# Expects a table from html2text after curl of gateway page:
#   curl --http0.9 -s http://192.168.1.1/admin/landingpage.fwd \
#     | html2text \
#     | awk -f …/router-stats.awk
# This script parses some key items and pretty-prints them at EN_up.

BEGIN {
  FS = "[|]"
  foundIP = 0
  ipPattern = "([0-9]{1,3}\\.){3}[0-9]{1,3}"
}

function clean(s) {
  gsub("_", " ", s)
  gsub(/^[ \t]+|[ \t]+$/,"", s)
  return s
}

function underline(s, wid, pad) {
  printf "\033[4m"
  printf "%-*s", wid, s
  printf "\033[0m"
  printf "%*s", pad, ""
}

function len(arr) {
  l = 0
  for (i in arr) { l++ }
  return l
}

function sum(arr) {
  tot = 0
  for (i in arr) { tot += arr[i] }
  return tot
}

/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {
  if (match($0, ipPattern)) {
    ipAddress = substr($0, RSTART, RLENGTH)
    foundIP = 1
  }
}

/ppp3.2___/ {
  ifce_rx_bytes = clean($4)
  ifce_rx_pkts  = clean($5)
  ifce_rx_errs  = clean($6)
  ifce_rx_drops = clean($7)
  ifce_tx_bytes = clean($8)
  ifce_tx_pkts  = clean($9)
  ifce_tx_errs  = clean($10)
  ifce_tx_drops = clean($11)
}

/Status:/ {
  status = clean($3)
}

/Mode:/ {
  mode = clean($3)
}

/Link_Power_State:/ {
  pwr_state = clean($3)
}

/SNR_Margin_\(dB\)/ {
  snr_dn = clean($3)
  snr_up = clean($4)
}

/Attainable_Rate_\(Kbps\)/ {
  attainable_dn = clean($3)
  attainable_up = clean($4)
}

/Rate_\(Kbps\)/ {
  rate_dn = clean($3)
  rate_up = clean($4)
}

/Attenuation_\(dB\)/ {
  attenuation_dn = clean($3)
  attenuation_up = clean($4)
}

/Output_Power_\(dBm\)/ {
  power_dn = clean($3)
  power_up = clean($4)
}

END {
  if (foundIP) {
    printf "Internet is Online. IP  : %s\n", ipAddress
    printf "Mode                    : %s\n", mode
    printf "Status                  : %s\n", status
    printf "Link Power State        : %s", pwr_state
    printf "\n"
    printf "                          "
    underline("Downstream", 12, 2)
    underline("Upstream", 12, 2)
    print
    printf "Attainable Rate (Kbps)  : %-10s    %s\n", attainable_dn, attainable_up
    printf "Output Power (dBm)      : %-10s    %s\n", power_dn, power_up
    printf "Attenuation (dB)        : %-10s    %s\n", attenuation_dn, attenuation_up
    printf "SNR Margin (dB)         : %-10s    %s\n", snr_dn, snr_up
    printf "\n"
    width[1] = 14
    width[2] = 12
    width[3] = 8
    width[4] = 8
    rpad = 2
    total_width = sum(width) + (len(width) - 1) * rpad
    underline("Interface : ppp3.2", 5 + total_width, 0)
    printf "\n     "
      underline("Bytes", width[1], rpad)
        underline("Packets", width[2], rpad)
          underline("Errors", width[3], rpad)
            underline("Drops", width[4], rpad)
    printf "\nRx:  "
    printf "%-*s ", width[1] + rpad - 1, ifce_rx_bytes
    printf "%-*s ", width[2] + rpad - 1, ifce_rx_pkts
    printf "%-*s ", width[3] + rpad - 1, ifce_rx_errs
    printf "%-*s ", width[4] + rpad - 1, ifce_rx_drops
    printf "\nTx:  "
    printf "%-*s ", width[1] + rpad - 1, ifce_tx_bytes
    printf "%-*s ", width[2] + rpad - 1, ifce_tx_pkts
    printf "%-*s ", width[3] + rpad - 1, ifce_tx_errs
    printf "%-*s ", width[4] + rpad - 1, ifce_tx_drops
    printf "\n\n"
    printf "NB: \n"
    printf "Power States : L0 ≔ full; L2 ≔ low; L3 ≔ idle.\n"
    printf "Attenuation  : 40–50 dB; ≤ 30 db is Excellent.\n"
    printf "SNR Margin   : > 6 dB. ≔ (SNR to sync at speed) - SNR\n"
  } else {
    print "Internet is Offline."
    printf "Status                  : %s\n\n", status
  }
}

