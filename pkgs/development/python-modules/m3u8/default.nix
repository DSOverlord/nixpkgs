{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  iso8601,
  bottle,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "m3u8";
  version = "5.1.0";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "globocom";
    repo = "m3u8";
    rev = "refs/tags/${version}";
    hash = "sha256-dvRs1FoyQz6D/G0mTC2SCUaCWP3UpxQpNw/oiaauaOE=";
  };

  build-system = [ setuptools ];

  dependencies = [ iso8601 ];

  nativeCheckInputs = [
    bottle
    pytestCheckHook
  ];

  disabledTests = [
    # Tests require network access
    "test_load_should_create_object_from_uri"
    "test_load_should_create_object_from_uri_with_relative_segments"
    "test_load_should_remember_redirect"
    "test_raise_timeout_exception_if_timeout_happens_when_loading_from_uri"
  ];

  pythonImportsCheck = [ "m3u8" ];

  meta = with lib; {
    description = "Python m3u8 parser";
    homepage = "https://github.com/globocom/m3u8";
    changelog = "https://github.com/globocom/m3u8/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ Scriptkiddi ];
  };
}
