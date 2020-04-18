import XCTest
@testable import SwiftyPodsDSL

final class SwiftyPodsDSLTests: XCTestCase {
    func testDependencyPropertyGeneratesExpectedString() {
        let property = DependencyProperty(key: "git", value: "repoHere")
        XCTAssertEqual(property.toString(), ":git => 'repoHere'")
    }
    
    func testDependencyWithVersionGeneratesExpectedString() {
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [])
        XCTAssertEqual(dependency.toString(tabs: 0).content, "pod 'aName', '1.2.3'")
    }
    
    func testDependencyWithVersionAndDependenciesGeneratesExpectedString() {
        let property = DependencyProperty(key: "git", value: "repoHere")
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [property,property])
        XCTAssertEqual(dependency.toString(tabs: 0).content, "pod 'aName', '1.2.3', :git => 'repoHere', :git => 'repoHere'")
    }
    
    func testTargetGeneratesExpectedString() {
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [], childTargets: [])
        let expected = """
target 'targetName' do
    project 'projectFile.xproj'
end
"""
        XCTAssertEqual(target.toString(tabs: 0).render(), expected)
    }
    
    func testTargetWithTabsGeneratesExpectedString() {
            let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [], childTargets: [])
            let expected = """
        target 'targetName' do
            project 'projectFile.xproj'
        end
    """
            XCTAssertEqual(target.toString(tabs: 1).render(), expected)
        }
    
    func testTargetWithDependencyGeneratesExpectedString() {
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [])
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [dependency], childTargets: [])
        let expected = """
    target 'targetName' do
        project 'projectFile.xproj'
        pod 'aName', '1.2.3'
    end
    """
        XCTAssertEqual(target.toString(tabs: 0).render(), expected)
    }
    
    func testTargetWithChildGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: false, dependencies: [], childTargets: [])
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [], childTargets: [child])
        let expected = """
    target 'targetName' do
        project 'projectFile.xproj'
        target 'childTarget' do
            project 'childProject.xproj'
        end
    end
    """
        XCTAssertEqual(target.toString(tabs: 0).render(), expected)
    }
    
    func testChildTargetGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: false, dependencies: [], childTargets: [])
        let expected = """
    target 'childTarget' do
        project 'childProject.xproj'
    end
    """
        XCTAssertEqual(child.toString(tabs: 0).render(), expected)
    }
    
    func testChildTargetWithPathsGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: true, dependencies: [], childTargets: [])
        let expected = """
    target 'childTarget' do
        project 'childProject.xproj'
        inherit! :search_paths
    end
    """
        XCTAssertEqual(child.toString(tabs: 0).render(), expected)
    }
    
    func testPodfileGeneratesExpectedString() {
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [], childTargets: [])
        let podfile = Podfile(targets: [target])
        let expected = """
        target 'targetName' do
            project 'projectFile.xproj'
        end
        """
        XCTAssertEqual(podfile.toString(), expected)
    }

    static var allTests = [
        ("testDependencyPropertyGeneratesExpectedString", testDependencyPropertyGeneratesExpectedString),
    ]
}
