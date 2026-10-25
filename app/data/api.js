
const API_BASE_URL = 'https://jsonplaceholder.typicode.com/';

export async function fetchPost(id) {
  const response = await fetch(`${API_BASE_URL}/posts/${id}`);

  // Below code matters because fetch() does not automatically reject its promise for HTTP responses such as 404 or 500. We must check response.ok ourselves.
  if (!response.ok) {
    throw new Error(`Request failed: HTTP ${response.status}`);
  }

  return response.json();
}
