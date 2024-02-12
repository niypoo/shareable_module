enum Role {
  owner,
  editor,
  viewer,
}

Role stringToRole(String? role) {
  switch (role) {
    case 'owner':
      return Role.owner;
    case 'editor':
      return Role.editor;
    case 'viewer':
      return Role.viewer;
    default:
      return Role.viewer;
  }
}
