from app.main import app
def test_root():
    client = app.test_client()
    res = client.get('/')
    assert res.status_code == 200
    data = res.get_json()
    assert 'version' in data
