void loadCallback (File f)
{
  try
  {
    byte[] data = loadBytes(f);
    File tempFile = File.createTempFile("guido", "arrezo");
    saveBytes(tempFile, decipher(secretKey, data));
    XML user=loadXML(tempFile.getAbsolutePath());
    tempFile.delete();
    XML username = user.getChild("name");
    XML library = user.getChild("library");
    XML progress = user.getChild("progress");
    XML score = user.getChild("score");
    XML[] exercise = progress.getChildren("exercise");
    for (int id = 0; id<exercise.length; id++)
    {
      int testval = exercise[id].getIntContent();
    }
    myTextArea.clear();
    println("Filename              "+f.getName());
    println("Computer User Name    "+username.getContent());
    println("Total Score           "+score.getContent());
    println("------------------------------------------------------------------------------------------------------");
    for (int id = 0; id<exercise.length; id++)
    {
      String thisScore = exercise[id].getContent();
      String exerciseID = exercise[id].getString("id");
      String started = exercise[id].getString("started");
      String completed = "";
      if (exercise[id].hasAttribute("completed"))
        completed = exercise[id].getString("completed"); 
      print("Exercise "+(id+1)+": \""+exerciseID+"\",");
      print("  started: "+started+",  completed: "+completed);
      println(",  best score: "+thisScore);
    }
    scrollStep = 5.0/exercise.length;
    scrollAmt = 1;
  }
  catch (Exception e) {
    showMessageDialog(null, "Could not load Latido user file.", "Latido User File Load Error", ERROR_MESSAGE);
  }
}
/**
 * Encrypt data
 * @param secretKey -   a secret key used for encryption
 * @param data      -   data to encrypt
 * @return  Encrypted data
 * @throws Exception
 */
byte[] cipher(String secretKey, byte[] data) throws Exception {
  // Key has to be of length 8
  if (secretKey == null || secretKey.length() != 8)
    throw new Exception("Invalid key length - 8 bytes key needed!");

  SecretKey key = new SecretKeySpec(secretKey.getBytes(), "DES");
  Cipher cipher = Cipher.getInstance("DES");
  cipher.init(Cipher.ENCRYPT_MODE, key);

  return cipher.doFinal(data);
}

/**
 * Decrypt data
 * @param secretKey -   a secret key used for decryption
 * @param data      -   data to decrypt
 * @return  Decrypted data
 * @throws Exception
 */
byte[] decipher(String secretKey, byte[] data) throws Exception {
  // Key has to be of length 8
  if (secretKey == null || secretKey.length() != 8)
    throw new Exception("Invalid key length - 8 bytes key needed!");

  SecretKey key = new SecretKeySpec(secretKey.getBytes(), "DES");
  Cipher cipher = Cipher.getInstance("DES");
  cipher.init(Cipher.DECRYPT_MODE, key);

  return cipher.doFinal(data);
}

