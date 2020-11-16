import 'lib/appwrite.dart';

void main(List<String> args) async {
  Client client = Client();

  client
      .setEndpoint('http://localhost:1668/v1') // Your Appwrite Endpoint
      .setProject('5fb1b4cf422f1') // Your project ID
      .setSelfSigned(); // Remove in production

  Response res = await createUSer(client);

  print(res.data);
}

Future<Response> createUSer(Client client) async {
  Account account = Account(client);

  Response user = await account.create(
      email: 'me@appwrite.io', password: 'password', name: 'My Name');

  Response session = await account.createSession(
      email: 'me@appwrite.io', password: 'password');

  return user;
}
