class AddMask {
  phone(String phoneNumber) {
    return "(" +
        phoneNumber.substring(0, 2) +
        ") " +
        phoneNumber.substring(2, 7) +
        "-" +
        phoneNumber.substring(7, phoneNumber.length);
  }

  rg(String rg) {
    return rg.substring(0, rg.length - 1) +
        '-' +
        rg.substring(rg.length - 1, rg.length);
  }
}
